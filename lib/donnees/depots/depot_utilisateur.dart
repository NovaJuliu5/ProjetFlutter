import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/domaine/entites/entite_utilisateur.dart';

class DepotUtilisateur {
  final ClientApi _api;
  DepotUtilisateur(this._api);

  Future<Resultat<EntiteUtilisateur>> obtenirProfil(String id) async {
    try {
      final response = await _api.get('/utilisateurs/$id');
      return Right(EntiteUtilisateur.fromJson(response.data));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Resultat<EntiteUtilisateur>> mettreAJourProfil(Map<String, dynamic> donnees) async {
    try {
      final response = await _api.put('/utilisateurs/profil', data: donnees);
      return Right(EntiteUtilisateur.fromJson(response.data));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }
}