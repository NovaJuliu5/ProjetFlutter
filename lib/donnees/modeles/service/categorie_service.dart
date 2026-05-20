import 'package:json_annotation/json_annotation.dart';
part 'categorie_service.g.dart';

@JsonSerializable()
class CategorieService {
  final String id;
  final String nom;
  final String slug;
  final String? description;
  final String? icone;
  final String? couleur;
  final String? imageUrl;
  final int ordre;
  final bool estActive;
  final String? parentId;

  CategorieService({
    required this.id,
    required this.nom,
    required this.slug,
    this.description,
    this.icone,
    this.couleur,
    this.imageUrl,
    required this.ordre,
    required this.estActive,
    this.parentId,
  });

  factory CategorieService.fromJson(Map<String, dynamic> json) => _$CategorieServiceFromJson(json);
}