import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';

class DepotService {
  final ClientApi _api;
  DepotService(this._api);

  Future<Resultat<List<EntiteService>>> obtenirServicesProches(double lat, double lon, int rayonKm) async {
    try {
      final response = await _api.get('/services/proches', query: {'lat': lat, 'lon': lon, 'rayon': rayonKm});
      final List list = response.data;
      return Right(list.map((e) => EntiteService.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Resultat<EntiteService>> creerService(Map<String, dynamic> data) async {
    try {
      final response = await _api.post('/services', data: data);
      return Right(EntiteService.fromJson(response.data));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Resultat<List<EntiteService>>> rechercherServices(String query) async {
    try {
      final response = await _api.get('/services/recherche', query: {'q': query});
      final List list = response.data;
      return Right(list.map((e) => EntiteService.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }
}