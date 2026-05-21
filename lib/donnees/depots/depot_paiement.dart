import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';

class DepotPaiement {
  // À implémenter dans la version 2 (paiements MVola / Orange Money)
  Future<Either<Echec, void>> effectuerPaiement(Map<String, dynamic> data) async {
    // Placeholder
    return const Right(null);
  }
}