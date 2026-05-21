import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/fournisseur_accueil.dart';
import 'package:help_neighbor/presentation/widgets/cartes/carte_service.dart';
import 'package:help_neighbor/presentation/widgets/communs/indicateur_chargement.dart';
import 'package:help_neighbor/presentation/widgets/communs/widget_erreur.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart';
import 'package:go_router/go_router.dart';

class EcranExplorer extends ConsumerStatefulWidget {
  const EcranExplorer({super.key});

  @override
  ConsumerState<EcranExplorer> createState() => _EcranExplorerState();
}

class _EcranExplorerState extends ConsumerState<EcranExplorer> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'Toutes';
  List<String> _categories = ['Toutes'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    // Récupérer les catégories depuis le backend (à implémenter)
    // Pour l'instant, on utilise une liste statique basée sur vos données
    // Idéalement, ajouter un endpoint GET /categories
    setState(() {
      _categories = [
        'Toutes',
        'Bricolage',
        'Jardinage',
        'Transport',
        'Informatique',
        'Cours',
        'Garde / Soin',
      ];
    });
  }

  List<EntiteService> _filterServices(List<EntiteService> services) {
    return services.where((service) {
      final matchesQuery = _searchQuery.isEmpty ||
          service.titre.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          service.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Toutes' ||
          service.categorie == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(servicesProchesProvider);
    final authState = ref.watch(authProvider);
    final userId = authState.utilisateur?.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorer'),
        actions: [
          if (userId != null)
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () => context.push('/profil/$userId'),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Rechercher un service...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _searchQuery = '');
                      },
                    )
                        : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      final cat = _categories[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: FilterChip(
                          label: Text(cat),
                          selected: _selectedCategory == cat,
                          onSelected: (selected) {
                            setState(() {
                              _selectedCategory = selected ? cat : 'Toutes';
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: servicesAsync.when(
        data: (services) {
          final filtered = _filterServices(services);
          if (filtered.isEmpty) {
            return const Center(child: Text('Aucun service trouvé'));
          }
          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) => CarteService(service: filtered[index]),
          );
        },
        loading: () => const IndicateurChargement(),
        error: (err, _) => WidgetErreur(message: err.toString()),
      ),
      bottomNavigationBar: BarreNavigationBasPersonnalisee(selectedIndex: 1),
    );
  }
}