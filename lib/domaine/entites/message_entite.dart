class MessageEntite {
  final String id;
  final String conversationId;
  final String expediteurId;
  final String contenu;
  final DateTime createdAt;
  final bool estLu;

  MessageEntite({
    required this.id,
    required this.conversationId,
    required this.expediteurId,
    required this.contenu,
    required this.createdAt,
    required this.estLu,
  });

  factory MessageEntite.fromJson(Map<String, dynamic> json) {
    return MessageEntite(
      id: json['id'],
      conversationId: json['conversation_id'],
      expediteurId: json['expediteur_id'],
      contenu: json['contenu'],
      createdAt: DateTime.parse(json['created_at']),
      estLu: json['est_lu'] ?? false,
    );
  }
}