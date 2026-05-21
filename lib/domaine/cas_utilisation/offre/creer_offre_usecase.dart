import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/donnees/depots/depot_offre.dart';
import 'package:help_neighbor/domaine/entites/entite_offre.dart';

class CreerOffreUseCase {
  final DepotOffre depot;
  CreerOffreUseCase(this.depot);

  Future<Either<Echec, EntiteOffre>> executer(Map<String, dynamic> data) {
    return depot.creerOffre(data);
  }
}