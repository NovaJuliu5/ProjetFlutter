class EntiteDemande {
  final String id;
  final String titre;
  final String description;
  final String statut;
  final DateTime createdAt;
  final String utilisateurNom;

  EntiteDemande({
    required this.id,
    required this.titre,
    required this.description,
    required this.statut,
    required this.createdAt,
    required this.utilisateurNom,
  });

  factory EntiteDemande.fromJson(Map<String, dynamic> json) {
    return EntiteDemande(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      statut: json['statut'],
      createdAt: DateTime.parse(json['created_at']),
      utilisateurNom: '${json['prenom']} ${json['nom']}',
    );
  }
}