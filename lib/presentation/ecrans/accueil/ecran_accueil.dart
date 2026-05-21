import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/fournisseur_accueil.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/en_tete_accueil.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/section_recherche.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/grille_categories.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/liste_services.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/widgets/liste_demandes.dart';
import 'package:help_neighbor/presentation/widgets/communs/indicateur_chargement.dart';
import 'package:help_neighbor/presentation/widgets/communs/widget_erreur.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart';

class EcranAccueil extends ConsumerWidget {
  const EcranAccueil({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final servicesAsync = ref.watch(servicesProchesProvider);
    final demandesAsync = ref.watch(demandesProchesProvider);
    final authState = ref.watch(authProvider);
    final userId = authState.utilisateur?.id;

    return Scaffold(
      appBar: AppBar(
        // Le titre sera affiché dans EnTeteAccueil, on le retire ici
        actions: [
          if (userId != null)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => context.push('/profil/$userId'),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(servicesProchesProvider);
          ref.invalidate(demandesProchesProvider);
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: CustomScrollView(
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
      ),
      bottomNavigationBar: BarreNavigationBasPersonnalisee(selectedIndex: 0),
    );
  }
}