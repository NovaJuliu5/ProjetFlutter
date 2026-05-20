import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_authentification.dart';
import 'package:help_neighbor/domaine/entites/entite_utilisateur.dart';

class InscriptionUseCase {
  final DepotAuthentification depot;
  InscriptionUseCase(this.depot);

  Future<Resultat<EntiteUtilisateur>> executer(String email, String password, String nom, String prenom) {
    return depot.inscription(email, password, nom, prenom);
  }
}