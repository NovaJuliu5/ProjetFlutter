import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/donnees/depots/depot_offre.dart';
import 'package:help_neighbor/domaine/entites/entite_offre.dart';

class GetOffresPourDemandeUseCase {
  final DepotOffre depot;
  GetOffresPourDemandeUseCase(this.depot);

  Future<Either<Echec, List<EntiteOffre>>> executer(String demandeId) {
    return depot.getOffresPourDemande(demandeId);
  }
}