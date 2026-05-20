import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_demande.dart';
import 'package:help_neighbor/domaine/entites/entite_demande.dart';

class ObtenirDemandesUseCase {
  final DepotDemande depot;
  ObtenirDemandesUseCase(this.depot);

  Future<Resultat<List<EntiteDemande>>> executer(double lat, double lon, int rayonKm) {
    return depot.obtenirDemandesProches(lat, lon, rayonKm);
  }
}