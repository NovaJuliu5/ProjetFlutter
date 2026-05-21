class EntiteOffre {
  final String id;
  final String demandeId;
  final String prestataireId;
  final String message;
  final double? prixPropose;
  final int? delaiPropose;
  final String statut;
  final DateTime createdAt;
  final String prestataireNom; // ajouté

  EntiteOffre({
    required this.id,
    required this.demandeId,
    required this.prestataireId,
    required this.message,
    this.prixPropose,
    this.delaiPropose,
    required this.statut,
    required this.createdAt,
    required this.prestataireNom,
  });

  factory EntiteOffre.fromJson(Map<String, dynamic> json) {
    return EntiteOffre(
      id: json['id'] ?? '',
      demandeId: json['demande_id'] ?? '',
      prestataireId: json['prestataire_id'] ?? '',
      message: json['message'] ?? '',
      prixPropose: json['prix_propose']?.toDouble(),
      delaiPropose: json['delai_propose'],
      statut: json['statut'] ?? 'en_attente',
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      prestataireNom: '${json['prenom'] ?? ''} ${json['nom'] ?? ''}'.trim(),
    );
  }
}