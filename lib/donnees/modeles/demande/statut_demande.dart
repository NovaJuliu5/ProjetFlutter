import 'package:json_annotation/json_annotation.dart';
part 'statut_demande.g.dart';

@JsonSerializable()
class StatutDemande {
  final String id;
  final String demandeId;
  final String statut;
  final DateTime createdAt;

  StatutDemande({
    required this.id,
    required this.demandeId,
    required this.statut,
    required this.createdAt,
  });

  factory StatutDemande.fromJson(Map<String, dynamic> json) => _$StatutDemandeFromJson(json);
}