class EntiteService {
  final String id;
  final String titre;
  final String description;
  final double prix;
  final String categorie;
  final String utilisateurId;
  final String utilisateurNom;
  final double distanceKm;
  final double noteMoyenne;
  final int nbAvis;
  final String? photoUrl; // AJOUTÉ

  EntiteService({
    required this.id,
    required this.titre,
    required this.description,
    required this.prix,
    required this.categorie,
    required this.utilisateurId,
    required this.utilisateurNom,
    required this.distanceKm,
    required this.noteMoyenne,
    required this.nbAvis,
    this.photoUrl, // AJOUTÉ
  });

  factory EntiteService.fromJson(Map<String, dynamic> json) {
    return EntiteService(
      id: json['id'] ?? '',
      titre: json['titre'] ?? '',
      description: json['description'] ?? '',
      prix: (json['prix'] ?? 0).toDouble(),
      categorie: json['categorie_nom'] ?? 'Sans catégorie',
      utilisateurId: json['utilisateur_id'] ?? '',
      utilisateurNom: '${json['prenom'] ?? ''} ${json['nom'] ?? ''}'.trim(),
      distanceKm: (json['distance_km'] ?? 0).toDouble(),
      noteMoyenne: (json['note_moyenne'] ?? 0).toDouble(),
      nbAvis: json['nb_avis'] ?? 0,
      photoUrl: json['photo_url'], // AJOUTÉ
    );
  }
}