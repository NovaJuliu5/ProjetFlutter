import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/donnees/depots/depot_conversation.dart';
import 'package:help_neighbor/domaine/entites/entite_conversation.dart';
import 'package:help_neighbor/domaine/entites/entite_message.dart';

final conversationListProvider = FutureProvider<List<EntiteConversation>>((ref) async {
  final depot = getIt<DepotConversation>();
  final result = await depot.getConversations();
  return result.fold(
        (echec) => throw Exception(echec.message),
        (list) => list,
  );
});

final conversationMessagesProvider = FutureProvider.family<List<EntiteMessage>, String>((ref, conversationId) async {
  final depot = getIt<DepotConversation>();
  final result = await depot.getMessages(conversationId);
  return result.fold(
        (echec) => throw Exception(echec.message),
        (messages) => messages,
  );
});