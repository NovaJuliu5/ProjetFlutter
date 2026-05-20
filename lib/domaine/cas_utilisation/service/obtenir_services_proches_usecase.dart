import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_service.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';

class ObtenirServicesProchesUseCase {
  final DepotService depot;
  ObtenirServicesProchesUseCase(this.depot);

  Future<Resultat<List<EntiteService>>> executer(double lat, double lon, int rayonKm) {
    return depot.obtenirServicesProches(lat, lon, rayonKm);
  }
}