import 'package:json_annotation/json_annotation.dart';
part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  final String id;
  final String? demandeId;
  final String? serviceId;
  final String? offreId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    this.demandeId,
    this.serviceId,
    this.offreId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}