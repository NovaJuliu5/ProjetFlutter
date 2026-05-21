import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/coeur/extensions/extensions_context.dart';
import 'package:help_neighbor/donnees/depots/depot_notification.dart';
import 'package:help_neighbor/domaine/entites/entite_notification.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_notification.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';

class EcranNotifications extends ConsumerStatefulWidget {
  const EcranNotifications({super.key});

  @override
  ConsumerState<EcranNotifications> createState() => _EcranNotificationsState();
}

class _EcranNotificationsState extends ConsumerState<EcranNotifications> {
  @override
  void initState() {
    super.initState();
    // Recharge les notifications chaque fois que l'écran est affiché
    Future.microtask(() => ref.invalidate(notificationsProvider));
  }

  Future<void> _rafraichir() async {
    ref.invalidate(notificationsProvider);
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    final notificationsAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: () async {
              final depot = getIt<DepotNotification>();
              final result = await depot.marquerToutCommeLu();
              result.fold(
                    (echec) => context.showSnackBar(echec.message, isError: true),
                    (_) => ref.invalidate(notificationsProvider),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _rafraichir,
        child: notificationsAsync.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return const Center(child: Text('Aucune notification'));
            }
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notif = notifications[index];
                return _NotificationItem(
                  notification: notif,
                  onTap: () async {
                    if (!notif.estLue) {
                      final depot = getIt<DepotNotification>();
                      await depot.marquerCommeLue(notif.id);
                      ref.invalidate(notificationsProvider);
                    }
                    if (notif.actionUrl != null && notif.actionUrl!.isNotEmpty) {
                      context.push(notif.actionUrl!);
                    }
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Erreur: $err')),
        ),
      ),
      bottomNavigationBar: BarreNavigationBasPersonnalisee(selectedIndex: 4), // Retirer const
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final EntiteNotification notification;
  final VoidCallback onTap;
  const _NotificationItem({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        _getIcon(notification.type),
        color: notification.estLue ? Colors.grey : Colors.blue,
      ),
      title: Text(
        notification.titre,
        style: TextStyle(
          fontWeight: notification.estLue ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(notification.message),
      trailing: Text(
        _formatDate(notification.createdAt),
        style: const TextStyle(fontSize: 12),
      ),
      onTap: onTap,
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'offre_recue':
        return Icons.request_quote;
      case 'offre_acceptee':
        return Icons.check_circle;
      case 'offre_refusee':
        return Icons.cancel;
      case 'nouveau_message':
        return Icons.message;
      default:
        return Icons.notifications;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays > 7) return '${date.day}/${date.month}';
    if (diff.inDays > 0) return 'il y a ${diff.inDays}j';
    if (diff.inHours > 0) return 'il y a ${diff.inHours}h';
    if (diff.inMinutes > 0) return 'il y a ${diff.inMinutes}min';
    return 'à l\'instant';
  }
}