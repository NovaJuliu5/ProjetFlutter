import 'package:dartz/dartz.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';
import 'package:help_neighbor/coeur/erreurs/gestionnaire_erreurs.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/domaine/entites/entite_conversation.dart';
import 'package:help_neighbor/domaine/entites/entite_message.dart';

class DepotConversation {
  final ClientApi _api;
  DepotConversation(this._api);

  Future<Either<Echec, List<EntiteConversation>>> getConversations() async {
    try {
      final response = await _api.get('/conversations');
      final List list = response.data;
      return Right(list.map((e) => EntiteConversation.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, String>> creerConversation(String autreId, {String? demandeId, String? serviceId}) async {
    try {
      final response = await _api.post('/conversations', data: {
        'autre_id': autreId,
        'demande_id': demandeId,
        'service_id': serviceId,
      });
      return Right(response.data['id']);
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, List<EntiteMessage>>> getMessages(String conversationId) async {
    try {
      final response = await _api.get('/conversations/$conversationId/messages');
      final List list = response.data;
      return Right(list.map((e) => EntiteMessage.fromJson(e)).toList());
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, EntiteMessage>> envoyerMessage(String conversationId, String contenu, {String? typeMessage}) async {
    try {
      final response = await _api.post('/conversations/$conversationId/messages', data: {
        'contenu': contenu,
        'type_message': typeMessage ?? 'texte',
      });
      return Right(EntiteMessage.fromJson(response.data));
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }

  Future<Either<Echec, void>> marquerCommeLu(String conversationId) async {
    try {
      await _api.put('/conversations/$conversationId/lire');
      return const Right(null);
    } catch (e) {
      return Left(GestionnaireErreurs.traiterErreur(e));
    }
  }
}