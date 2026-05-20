import 'package:json_annotation/json_annotation.dart';
part 'avis_service.g.dart';

@JsonSerializable()
class AvisService {
  final String id;
  final String auteurId;
  final String cibleId;
  final String? serviceId;
  final String? demandeId;
  final String? commentaire;
  final bool signalement;
  final String? motifSignalement;
  final bool verifieParAdmin;
  final String? reponse;
  final DateTime? reponseLe;
  final DateTime createdAt;
  final int noteGlobale;

  AvisService({
    required this.id,
    required this.auteurId,
    required this.cibleId,
    this.serviceId,
    this.demandeId,
    this.commentaire,
    required this.signalement,
    this.motifSignalement,
    required this.verifieParAdmin,
    this.reponse,
    this.reponseLe,
    required this.createdAt,
    required this.noteGlobale,
  });

  factory AvisService.fromJson(Map<String, dynamic> json) => _$AvisServiceFromJson(json);
}