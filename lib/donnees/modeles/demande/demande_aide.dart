import 'package:json_annotation/json_annotation.dart';
part 'demande_aide.g.dart';

@JsonSerializable()
class DemandeAide {
  final String id;
  final String utilisateurId;
  final String categorieId;
  final String titre;
  final String description;
  final int nombreOffres;
  final int nombreVues;
  final bool estVerifiee;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime expireLe;
  final DateTime? closedAt;

  DemandeAide({
    required this.id,
    required this.utilisateurId,
    required this.categorieId,
    required this.titre,
    required this.description,
    required this.nombreOffres,
    required this.nombreVues,
    required this.estVerifiee,
    required this.createdAt,
    required this.updatedAt,
    required this.expireLe,
    this.closedAt,
  });

  factory DemandeAide.fromJson(Map<String, dynamic> json) => _$DemandeAideFromJson(json);
  Map<String, dynamic> toJson() => _$DemandeAideToJson(this);
}