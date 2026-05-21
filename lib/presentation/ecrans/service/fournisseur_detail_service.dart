import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';
import 'package:help_neighbor/presentation/widgets/communs/etoiles_evaluation.dart';

class EcranDetailService extends ConsumerWidget {
  final String id;
  const EcranDetailService({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ici vous devriez charger le service depuis l'API avec son ID.
    // Pour l'instant, on simule avec des données factices.
    final service = EntiteService(
      id: id,
      titre: 'Service exemple',
      description: 'Description détaillée du service...',
      prix: 5000,
      categorie: 'Bricolage',
      utilisateurId: 'u1',
      utilisateurNom: 'Jean Dupont',
      distanceKm: 1.2,
      noteMoyenne: 4.5,
      nbAvis: 12,
    );

    return Scaffold(
      appBar: AppBar(title: Text(service.titre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(service.utilisateurNom[0]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(service.utilisateurNom,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          EtoilesEvaluation(note: service.noteMoyenne),
                          const SizedBox(width: 4),
                          Text('${service.noteMoyenne.toStringAsFixed(1)} (${service.nbAvis} avis)'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(service.description),
            const SizedBox(height: 16),
            Text('Catégorie : ${service.categorie}'),
            Text('Distance : ${service.distanceKm.toStringAsFixed(1)} km'),
            Text('Prix : ${service.prix} Ar/h'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Contacter le prestataire → ouvrir la conversation
              },
              child: const Text('Contacter'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BarreNavigationBasPersonnalisee(selectedIndex: 0),
    );
  }
}