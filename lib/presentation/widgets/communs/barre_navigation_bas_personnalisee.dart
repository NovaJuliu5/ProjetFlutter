import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_notification.dart';

class BarreNavigationBasPersonnalisee extends ConsumerWidget {
  final int selectedIndex;
  const BarreNavigationBasPersonnalisee({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final userId = authState.utilisateur?.id;
    final hasUnread = ref.watch(hasUnreadNotificationsProvider);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        const BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorer'),
        const BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Publier'),
        const BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        BottomNavigationBarItem(
          icon: _buildNotificationIcon(hasUnread),
          label: 'Alertes',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/accueil');
            break;
          case 1:
            context.go('/explorer');
            break;
          case 2:
            context.go('/creer-demande');
            break;
          case 3:
            context.go('/discussions');
            break;
          case 4:
            context.go('/notifications');
            break;
        }
      },
    );
  }

  Widget _buildNotificationIcon(AsyncValue<bool> hasUnread) {
    return hasUnread.when(
      data: (hasUnread) {
        if (hasUnread) {
          return Stack(
            children: [
              const Icon(Icons.notifications),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Icon(Icons.notifications);
        }
      },
      loading: () => const Icon(Icons.notifications),
      error: (_, __) => const Icon(Icons.notifications),
    );
  }
}