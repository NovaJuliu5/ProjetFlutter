import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/donnees/depots/depot_notification.dart';
import 'package:help_neighbor/domaine/entites/entite_notification.dart';

final notificationsProvider = FutureProvider<List<EntiteNotification>>((ref) async {
  final depot = getIt<DepotNotification>();
  final result = await depot.getNotifications();
  return result.fold(
        (echec) => throw Exception(echec.message),
        (list) => list,
  );
});

final hasUnreadNotificationsProvider = FutureProvider<bool>((ref) async {
  final notifications = await ref.watch(notificationsProvider.future);
  return notifications.any((n) => !n.estLue);
});