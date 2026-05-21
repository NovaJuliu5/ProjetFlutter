class EntiteNotification {
  final String id;
  final String type;
  final String titre;
  final String message;
  final Map<String, dynamic>? donnees;
  final bool estLue;
  final DateTime createdAt;
  final String? actionUrl;

  EntiteNotification({
    required this.id,
    required this.type,
    required this.titre,
    required this.message,
    this.donnees,
    required this.estLue,
    required this.createdAt,
    this.actionUrl,
  });

  factory EntiteNotification.fromJson(Map<String, dynamic> json) {
    return EntiteNotification(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      titre: json['titre'] ?? '',
      message: json['message'] ?? '',
      donnees: json['donnees'] != null ? Map<String, dynamic>.from(json['donnees']) : null,
      estLue: json['est_lue'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      actionUrl: json['action_url'],
    );
  }
}