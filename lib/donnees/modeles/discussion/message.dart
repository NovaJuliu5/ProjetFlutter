import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class Message {
  final String id;
  final String conversationId;
  final String expediteurId;
  final String contenu;
  final String typeMessage;
  final String? mediaUrl;
  final bool estLu;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.conversationId,
    required this.expediteurId,
    required this.contenu,
    required this.typeMessage,
    this.mediaUrl,
    required this.estLu,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}