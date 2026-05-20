import 'package:json_annotation/json_annotation.dart';
part 'offre_demande.g.dart';

@JsonSerializable()
class OffreDemande {
  final String id;
  final String demandeId;
  final String prestataireId;
  final String message;
  final DateTime createdAt;
  final DateTime? reponseLe;
  final double? prixPropose;
  final int? delaiPropose;

  OffreDemande({
    required this.id,
    required this.demandeId,
    required this.prestataireId,
    required this.message,
    required this.createdAt,
    this.reponseLe,
    this.prixPropose,
    this.delaiPropose,
  });

  factory OffreDemande.fromJson(Map<String, dynamic> json) => _$OffreDemandeFromJson(json);
}