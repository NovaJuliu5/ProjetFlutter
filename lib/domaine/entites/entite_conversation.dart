class EntiteConversation {
  final String id;
  final String? demandeId;
  final String? serviceId;
  final String autreId;
  final String autreNom;
  final String? dernierMessage;
  final DateTime? derniereActivite;
  final DateTime createdAt;

  EntiteConversation({
    required this.id,
    this.demandeId,
    this.serviceId,
    required this.autreId,
    required this.autreNom,
    this.dernierMessage,
    this.derniereActivite,
    required this.createdAt,
  });

  factory EntiteConversation.fromJson(Map<String, dynamic> json) {
    return EntiteConversation(
      id: json['id'] ?? '',
      demandeId: json['demande_id'],
      serviceId: json['service_id'],
      autreId: json['autre_id'] ?? '',
      autreNom: '${json['autre_prenom'] ?? ''} ${json['autre_nom'] ?? ''}'.trim(),
      dernierMessage: json['dernier_message'],
      derniereActivite: json['derniere_activite'] != null ? DateTime.parse(json['derniere_activite']) : null,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}