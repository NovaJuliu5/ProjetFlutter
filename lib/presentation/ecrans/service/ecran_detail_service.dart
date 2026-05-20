import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';
// ...

class EcranDetailService extends ConsumerWidget {
  final String id;
  const EcranDetailService({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Simulons un chargement depuis un provider (à créer)
    final service = EntiteService(
      id: id,
      titre: 'Jardinage',
      description: 'Tonte de pelouse, taille de haies',
      prix: 25.0,
      categorie: 'Jardin',
      utilisateurId: 'u1',
      utilisateurNom: 'Jean Dupont',
      distanceKm: 2.3,
      noteMoyenne: 4.8,
    );
    return Scaffold(
      appBar: AppBar(title: Text(service.titre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(service.description),
            const SizedBox(height: 8),
            Text('Prix: ${service.prix} €', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Catégorie: ${service.categorie}'),
            Text('Proposé par: ${service.utilisateurNom}'),
            Text('Distance: ${service.distanceKm.toStringAsFixed(1)} km'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Contacter'),
            ),
          ],
        ),
      ),
    );
  }
}