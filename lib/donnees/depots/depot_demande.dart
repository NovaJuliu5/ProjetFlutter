import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/domaine/entites/entite_demande.dart';

class DepotDemande {
  final ClientApi _api;
  DepotDemande(this._api);

  Future<Resultat<List<EntiteDemande>>> obtenirDemandesProches(double lat, double lon, int rayonKm) async {
    try {
      final response = await _api.get('/demandes/proches', query: {'lat': lat, 'lon': lon, 'rayon': rayonKm});
      final List list = response.data;
      return Right(list.map((e) => EntiteDemande.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Resultat<EntiteDemande>> creerDemande(Map<String, dynamic> data) async {
    try {
      final response = await _api.post('/demandes', data: data);
      return Right(EntiteDemande.fromJson(response.data));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }
}