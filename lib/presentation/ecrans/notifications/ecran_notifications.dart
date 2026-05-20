import 'package:flutter/material.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';

class EcranNotifications extends StatelessWidget {
  const EcranNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView(
        children: const [
          ListTile(title: Text('Rija T. a répondu à votre demande de plomberie'), subtitle: Text('Il y a 5 min')),
          ListTile(title: Text('Vonjy O. vous a laissé un avis 5 étoiles !'), subtitle: Text('Il y a 2h')),
          ListTile(title: Text('Hery M. habite maintenant à 500m de vous'), subtitle: Text('Hier')),
          ListTile(title: Text('Nouvelle demande urgente : transport de courses à 150m'), subtitle: Text('Hier')),
          ListTile(title: Text('Votre demande de jardinage a été acceptée par Sandrine C.'), subtitle: Text('Il y a 2 jours')),
        ],
      ),
      bottomNavigationBar: const BarreNavigationBasPersonnalisee(selectedIndex: 4),
    );
  }
}