import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/depots/depot_authentification.dart';
import 'package:help_neighbor/domaine/entites/entite_utilisateur.dart';

class ConnexionUseCase {
  final DepotAuthentification depot;
  ConnexionUseCase(this.depot);

  Future<Resultat<EntiteUtilisateur>> executer(String email, String password) {
    return depot.connexion(email, password);
  }
}