import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BarreNavigationBasPersonnalisee extends StatelessWidget {
  final int selectedIndex;
  const BarreNavigationBasPersonnalisee({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorer'),
        BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Publier'),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alertes'),
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
}