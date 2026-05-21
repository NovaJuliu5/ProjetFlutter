class EntiteMessage {
  final String id;
  final String conversationId;
  final String expediteurId;
  final String expediteurNom;
  final String contenu;
  final String typeMessage;
  final String? mediaUrl;
  final bool estLu;
  final DateTime createdAt;

  EntiteMessage({
    required this.id,
    required this.conversationId,
    required this.expediteurId,
    required this.expediteurNom,
    required this.contenu,
    required this.typeMessage,
    this.mediaUrl,
    required this.estLu,
    required this.createdAt,
  });

  factory EntiteMessage.fromJson(Map<String, dynamic> json) {
    return EntiteMessage(
      id: json['id'] ?? '',
      conversationId: json['conversation_id'] ?? '',
      expediteurId: json['expediteur_id'] ?? '',
      expediteurNom: '${json['expediteur_prenom'] ?? ''} ${json['expediteur_nom'] ?? ''}'.trim(),
      contenu: json['contenu'] ?? '',
      typeMessage: json['type_message'] ?? 'texte',
      mediaUrl: json['media_url'],
      estLu: json['est_lu'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}