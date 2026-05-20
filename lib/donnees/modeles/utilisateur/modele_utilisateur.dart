import 'package:json_annotation/json_annotation.dart';
part 'modele_utilisateur.g.dart';

@JsonSerializable()
class ModeleUtilisateur {
  final String id;
  final String email;
  final String? telephone;
  @JsonKey(name: 'mot_de_passe_hash')
  final String? motDePasseHash;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  ModeleUtilisateur({
    required this.id,
    required this.email,
    this.telephone,
    this.motDePasseHash,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory ModeleUtilisateur.fromJson(Map<String, dynamic> json) => _$ModeleUtilisateurFromJson(json);
  Map<String, dynamic> toJson() => _$ModeleUtilisateurToJson(this);
}