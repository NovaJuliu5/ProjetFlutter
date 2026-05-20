const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'helpneighbor_db',
  password: 'admin123',
  port: 5432,
});

const JWT_SECRET = 'votre_secret_jwt';

// ---------- Authentification ----------
app.post('/api/auth/connexion', async (req, res) => {
  const { email, password } = req.body;
  try {
    const result = await pool.query(
      'SELECT u.id, u.email, p.nom, p.prenom, u.mot_de_passe_hash FROM utilisateurs u LEFT JOIN profils p ON u.id = p.utilisateur_id WHERE u.email = $1',
      [email]
    );
    if (result.rows.length === 0) return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
    const user = result.rows[0];
    const valid = await bcrypt.compare(password, user.mot_de_passe_hash);
    if (!valid) return res.status(401).json({ message: 'Email ou mot de passe incorrect' });
    const token = jwt.sign({ id: user.id }, JWT_SECRET, { expiresIn: '7d' });
    res.json({ token, utilisateur: { id: user.id, email: user.email, nom: user.nom, prenom: user.prenom, note_moyenne: 0 } });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

app.post('/api/auth/inscription', async (req, res) => {
  const { email, password, nom, prenom } = req.body;
  const hashed = await bcrypt.hash(password, 10);
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    const userRes = await client.query(
      'INSERT INTO utilisateurs (email, mot_de_passe_hash) VALUES ($1, $2) RETURNING id',
      [email, hashed]
    );
    const userId = userRes.rows[0].id;
    await client.query(
      'INSERT INTO profils (utilisateur_id, nom, prenom) VALUES ($1, $2, $3)',
      [userId, nom, prenom]
    );
    await client.query('COMMIT');
    const token = jwt.sign({ id: userId }, JWT_SECRET, { expiresIn: '7d' });
    res.json({ token, utilisateur: { id: userId, email, nom, prenom, note_moyenne: 0 } });
  } catch (err) {
    await client.query('ROLLBACK');
    res.status(500).json({ message: err.message });
  } finally {
    client.release();
  }
});

// ---------- Profil ----------
app.get('/api/utilisateurs/:id', authenticateToken, async (req, res) => {
  const { id } = req.params;
  const result = await pool.query(
    'SELECT u.id, u.email, p.nom, p.prenom, p.photo_url FROM utilisateurs u LEFT JOIN profils p ON u.id = p.utilisateur_id WHERE u.id = $1',
    [id]
  );
  res.json(result.rows[0]);
});

app.put('/api/utilisateurs/profil', authenticateToken, async (req, res) => {
  const userId = req.user.id;
  const { nom, prenom, photo_url } = req.body;
  await pool.query(
    'UPDATE profils SET nom = COALESCE($1, nom), prenom = COALESCE($2, prenom), photo_url = COALESCE($3, photo_url) WHERE utilisateur_id = $4',
    [nom, prenom, photo_url, userId]
  );
  res.json({ message: 'Profil mis à jour' });
});

// ---------- Services ----------
app.get('/api/services/proches', authenticateToken, async (req, res) => {
  const { lat, lon, rayon } = req.query;
  const result = await pool.query(`
    SELECT s.id, s.titre, s.description, sp.prix_fixe as prix,
           c.nom as categorie_nom, s.utilisateur_id, p.nom, p.prenom,
           0 as distance_km, COALESCE(AVG(an.note_globale), 0) as note_moyenne
    FROM services s
    JOIN categories c ON s.categorie_id = c.id
    JOIN profils p ON s.utilisateur_id = p.utilisateur_id
    LEFT JOIN services_prix sp ON s.id = sp.service_id
    LEFT JOIN avis a ON s.id = a.service_id
    LEFT JOIN avis_notes an ON a.id = an.avis_id
    WHERE s.disponible = true
    GROUP BY s.id, c.nom, p.nom, p.prenom, sp.prix_fixe
    LIMIT 20
  `);
  res.json(result.rows);
});

app.post('/api/services', authenticateToken, async (req, res) => {
  const { titre, description, categorie_id, prix } = req.body;
  const userId = req.user.id;
  const result = await pool.query(
    'INSERT INTO services (utilisateur_id, categorie_id, titre, description) VALUES ($1, $2, $3, $4) RETURNING id',
    [userId, categorie_id, titre, description]
  );
  if (prix) {
    await pool.query('INSERT INTO services_prix (service_id, prix_fixe) VALUES ($1, $2)', [result.rows[0].id, prix]);
  }
  res.json({ id: result.rows[0].id });
});

app.get('/api/services/recherche', authenticateToken, async (req, res) => {
  const { q } = req.query;
  const result = await pool.query(
    `SELECT s.id, s.titre, s.description, sp.prix_fixe as prix,
            c.nom as categorie_nom, s.utilisateur_id, p.nom, p.prenom
     FROM services s
     JOIN categories c ON s.categorie_id = c.id
     JOIN services_prix sp ON s.id = sp.service_id
     JOIN profils p ON s.utilisateur_id = p.utilisateur_id
     WHERE s.titre ILIKE $1 OR s.description ILIKE $1`,
    [`%${q}%`]
  );
  res.json(result.rows);
});

// ---------- Demandes ----------
app.get('/api/demandes/proches', authenticateToken, async (req, res) => {
  const result = await pool.query(`
    SELECT d.id, d.titre, d.description, ds.statut, d.created_at, p.nom, p.prenom
    FROM demandes d
    JOIN demandes_statuts ds ON d.id = ds.demande_id
    JOIN profils p ON d.utilisateur_id = p.utilisateur_id
    WHERE ds.statut = 'ouverte'
    ORDER BY d.created_at DESC
    LIMIT 20
  `);
  res.json(result.rows);
});

app.post('/api/demandes', authenticateToken, async (req, res) => {
  const { titre, description, categorie_id } = req.body;
  const userId = req.user.id;
  const result = await pool.query(
    'INSERT INTO demandes (utilisateur_id, categorie_id, titre, description) VALUES ($1, $2, $3, $4) RETURNING id',
    [userId, categorie_id, titre, description]
  );
  await pool.query('INSERT INTO demandes_statuts (demande_id, statut) VALUES ($1, $2)', [result.rows[0].id, 'ouverte']);
  res.json({ id: result.rows[0].id });
});

// ---------- Discussions ----------
app.get('/api/conversations/:id/messages', authenticateToken, async (req, res) => {
  const { id } = req.params;
  const result = await pool.query(
    'SELECT * FROM messages WHERE conversation_id = $1 ORDER BY created_at ASC',
    [id]
  );
  res.json(result.rows);
});

app.post('/api/conversations/:id/messages', authenticateToken, async (req, res) => {
  const { id } = req.params;
  const { contenu } = req.body;
  const expediteurId = req.user.id;
  const result = await pool.query(
    'INSERT INTO messages (conversation_id, expediteur_id, contenu) VALUES ($1, $2, $3) RETURNING *',
    [id, expediteurId, contenu]
  );
  res.json(result.rows[0]);
});

// Middleware d'authentification JWT
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  if (!token) return res.sendStatus(401);
  jwt.verify(token, JWT_SECRET, (err, user) => {
    if (err) return res.sendStatus(403);
    req.user = user;
    next();
  });
}

const PORT = 3000;
app.listen(PORT, () => console.log(`Backend démarré sur http://localhost:${PORT}`));