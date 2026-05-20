import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/donnees/sources_donnees/locales/aide_preferences.dart';
import 'package:help_neighbor/domaine/entites/entite_utilisateur.dart';

class DepotAuthentification {
  final ClientApi _api;
  DepotAuthentification(this._api);

  Future<Either<Echec, EntiteUtilisateur>> connexion(String email, String password) async {
    try {
      final response = await _api.post('/auth/connexion', data: {'email': email, 'password': password});
      final data = response.data;
      await AidePreferences.sauvegarderToken(data['token']);
      await getIt<FlutterSecureStorage>().write(key: 'token', value: data['token']);
      return Right(EntiteUtilisateur.fromJson(data['utilisateur']));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, EntiteUtilisateur>> inscription(String email, String password, String nom, String prenom) async {
    try {
      final response = await _api.post('/auth/inscription', data: {
        'email': email,
        'password': password,
        'nom': nom,
        'prenom': prenom,
      });
      final data = response.data;
      await AidePreferences.sauvegarderToken(data['token']);
      await getIt<FlutterSecureStorage>().write(key: 'token', value: data['token']);
      return Right(EntiteUtilisateur.fromJson(data['utilisateur']));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<void> deconnexion() async {
    await AidePreferences.effacerToken();
    await getIt<FlutterSecureStorage>().delete(key: 'token');
  }
}