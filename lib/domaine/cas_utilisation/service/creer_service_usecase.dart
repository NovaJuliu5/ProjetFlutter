import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_service.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';

class CreerServiceUseCase {
  final DepotService depot;
  CreerServiceUseCase(this.depot);

  Future<Resultat<EntiteService>> executer(Map<String, dynamic> data) {
    return depot.creerService(data);
  }
}