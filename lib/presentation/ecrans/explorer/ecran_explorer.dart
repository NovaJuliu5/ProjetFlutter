import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/fournisseur_accueil.dart';
import 'package:help_neighbor/presentation/widgets/cartes/carte_service.dart';
import 'package:help_neighbor/presentation/widgets/communs/indicateur_chargement.dart';
import 'package:help_neighbor/presentation/widgets/communs/widget_erreur.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';

class EcranExplorer extends ConsumerWidget {
  const EcranExplorer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProchesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Explorer')),
      body: servicesAsync.when(
        data: (services) => ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) => CarteService(service: services[index]),
        ),
        loading: () => const IndicateurChargement(),
        error: (err, _) => WidgetErreur(message: err.toString()),
      ),
      bottomNavigationBar: const BarreNavigationBasPersonnalisee(selectedIndex: 1),
    );
  }
}