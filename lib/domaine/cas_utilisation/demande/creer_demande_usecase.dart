import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_demande.dart';
import 'package:help_neighbor/domaine/entites/entite_demande.dart';

class CreerDemandeUseCase {
  final DepotDemande depot;
  CreerDemandeUseCase(this.depot);

  Future<Resultat<EntiteDemande>> executer(Map<String, dynamic> data) {
    return depot.creerDemande(data);
  }
}