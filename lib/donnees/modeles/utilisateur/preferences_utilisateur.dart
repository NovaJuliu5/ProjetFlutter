import 'package:json_annotation/json_annotation.dart';
part 'preferences_utilisateur.g.dart';

@JsonSerializable()
class PreferencesUtilisateur {
  final String id;
  final String utilisateurId;
  final String langue;
  final String theme;
  final bool notificationsActives;
  final bool notificationsEmail;
  final bool notificationsPush;
  final int rayonRechercheKm;

  PreferencesUtilisateur({
    required this.id,
    required this.utilisateurId,
    required this.langue,
    required this.theme,
    required this.notificationsActives,
    required this.notificationsEmail,
    required this.notificationsPush,
    required this.rayonRechercheKm,
  });

  factory PreferencesUtilisateur.fromJson(Map<String, dynamic> json) => _$PreferencesUtilisateurFromJson(json);
  Map<String, dynamic> toJson() => _$PreferencesUtilisateurToJson(this);
}