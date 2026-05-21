import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/domaine/entites/entite_notification.dart';

class DepotNotification {
  final ClientApi _api;
  DepotNotification(this._api);

  Future<Either<Echec, List<EntiteNotification>>> getNotifications({int limit = 50, int offset = 0}) async {
    try {
      final response = await _api.get('/notifications', query: {'limit': limit, 'offset': offset});
      final List list = response.data;
      return Right(list.map((e) => EntiteNotification.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, void>> marquerCommeLue(String notificationId) async {
    try {
      await _api.put('/notifications/$notificationId/lire');
      return const Right(null);
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, void>> marquerToutCommeLu() async {
    try {
      await _api.put('/notifications/lire-tout');
      return const Right(null);
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }
}