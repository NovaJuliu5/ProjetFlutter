import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/fournisseur_accueil.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/en_tete_accueil.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/section_recherche.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/grille_categories.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/liste_services.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/liste_demandes.dart';
import 'package:help_neighbor/presentation/widgets/communs/indicateur_chargement.dart';
import 'package:help_neighbor/presentation/widgets/communs/widget_erreur.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';

class EcranAccueil extends ConsumerWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProchesProvider);
    final demandesAsync = ref.watch(demandesProchesProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const EnTeteAccueil(),
          const SliverToBoxAdapter(child: SectionRecherche()),
          const SliverToBoxAdapter(child: GrilleCategories()),
          SliverToBoxAdapter(
            child: servicesAsync.when(
              data: (services) => ListeServices(services: services),
              loading: () => const IndicateurChargement(),
              error: (err, _) => WidgetErreur(message: err.toString()),
            ),
          ),
          SliverToBoxAdapter(
            child: demandesAsync.when(
              data: (demandes) => ListeDemandes(demandes: demandes),
              loading: () => const IndicateurChargement(),
              error: (err, _) => WidgetErreur(message: err.toString()),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BarreNavigationBasPersonnalisee(),
    );
  }
}