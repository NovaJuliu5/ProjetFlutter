import 'package:help_neighbor/donnees/depots/depot_authentification.dart';

class DeconnexionUseCase {
  final DepotAuthentification depot;
  DeconnexionUseCase(this.depot);

  Future<void> executer() => depot.deconnexion();
}