import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_service.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';

class RechercherServicesUseCase {
  final DepotService depot;
  RechercherServicesUseCase(this.depot);

  Future<Resultat<List<EntiteService>>> executer(String query) {
    return depot.rechercherServices(query);
  }
}