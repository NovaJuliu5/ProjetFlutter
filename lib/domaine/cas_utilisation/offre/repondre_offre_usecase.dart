
import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/donnees/depots/depot_offre.dart';

class RepondreOffreUseCase {
  final DepotOffre depot;
  RepondreOffreUseCase(this.depot);

  Future<Either<Echec, void>> executer(String offreId, String statut) {
    return depot.repondreOffre(offreId, statut);
  }
}