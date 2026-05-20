import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/domaine/entites/message_entite.dart';

class DepotDiscussion {
  final ClientApi _api;
  DepotDiscussion(this._api);

  Future<Resultat<List<MessageEntite>>> obtenirMessages(String conversationId) async {
    try {
      final response = await _api.get('/conversations/$conversationId/messages');
      final List list = response.data;
      return Right(list.map((e) => MessageEntite.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Resultat<MessageEntite>> envoyerMessage(String conversationId, String contenu) async {
    try {
      final response = await _api.post('/conversations/$conversationId/messages', data: {'contenu': contenu});
      return Right(MessageEntite.fromJson(response.data));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }
}