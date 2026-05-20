class EntiteUtilisateur {
  final String id;
  final String email;
  final String? telephone;
  final String? nom;
  final String? prenom;
  final String? photoUrl;
  final double noteMoyenne;

  EntiteUtilisateur({
    required this.id,
    required this.email,
    this.telephone,
    this.nom,
    this.prenom,
    this.photoUrl,
    required this.noteMoyenne,
  });

  factory EntiteUtilisateur.fromJson(Map<String, dynamic> json) {
    return EntiteUtilisateur(
      id: json['id'],
      email: json['email'],
      telephone: json['telephone'],
      nom: json['nom'],
      prenom: json['prenom'],
      photoUrl: json['photo_url'],
      noteMoyenne: (json['note_moyenne'] ?? 0).toDouble(),
    );
  }
}