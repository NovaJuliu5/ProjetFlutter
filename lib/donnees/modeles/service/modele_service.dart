import 'package:json_annotation/json_annotation.dart';
part 'modele_service.g.dart';

@JsonSerializable()
class ModeleService {
  final String id;
  final String utilisateurId;
  final String categorieId;
  final String titre;
  final String description;
  final bool disponible;
  final int nombreVues;
  final int nombreClics;
  final int nombreFavoris;
  final double tauxReussite;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? publieLe;
  final DateTime? expireLe;
  final DateTime? deletedAt;

  ModeleService({
    required this.id,
    required this.utilisateurId,
    required this.categorieId,
    required this.titre,
    required this.description,
    required this.disponible,
    required this.nombreVues,
    required this.nombreClics,
    required this.nombreFavoris,
    required this.tauxReussite,
    required this.createdAt,
    required this.updatedAt,
    this.publieLe,
    this.expireLe,
    this.deletedAt,
  });

  factory ModeleService.fromJson(Map<String, dynamic> json) => _$ModeleServiceFromJson(json);
  Map<String, dynamic> toJson() => _$ModeleServiceToJson(this);
}