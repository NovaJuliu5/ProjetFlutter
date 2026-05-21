import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/domaine/entites/entite_demande.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';
import 'package:help_neighbor/presentation/widgets/cartes/carte_demande.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/fournisseur_accueil.dart';
import 'package:help_neighbor/coeur/extensions/extensions_context.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart';

class EcranMesDemandes extends ConsumerStatefulWidget {
  const EcranMesDemandes({super.key});

  @override
  ConsumerState<EcranMesDemandes> createState() => _EcranMesDemandesState();
}

class _EcranMesDemandesState extends ConsumerState<EcranMesDemandes> {
  List<EntiteDemande> _mesDemandes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _chargerMesDemandes();
  }

  Future<void> _chargerMesDemandes() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final authState = ref.read(authProvider);
      final utilisateurId = authState.utilisateur?.id;
      if (utilisateurId == null) {
        setState(() {
          _error = 'Utilisateur non connecté';
          _isLoading = false;
        });
        return;
      }

      // Récupérer toutes les demandes depuis le provider existant
      final allDemandesAsync = await ref.read(demandesProchesProvider.future);
      final toutesLesDemandes = allDemandesAsync; // c'est une List<EntiteDemande>

      // Filtrer pour garder uniquement celles de l'utilisateur
      final mesDemandes = toutesLesDemandes.where((d) => d.utilisateurId == utilisateurId).toList();
      setState(() {
        _mesDemandes = mesDemandes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _rafraichir() async {
    // Invalider le provider pour recharger toutes les demandes
    ref.invalidate(demandesProchesProvider);
    await _chargerMesDemandes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes demandes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _rafraichir,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erreur : $_error'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _rafraichir,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      )
          : _mesDemandes.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Vous n\'avez publié aucune demande.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/creer-demande');
              },
              child: const Text('Publier une demande'),
            ),
          ],
        ),
      )
          : RefreshIndicator(
        onRefresh: _rafraichir,
        child: ListView.builder(
          itemCount: _mesDemandes.length,
          itemBuilder: (context, index) {
            final demande = _mesDemandes[index];
            return CarteDemande(demande: demande);
          },
        ),
      ),
      bottomNavigationBar: const BarreNavigationBasPersonnalisee(selectedIndex: 0),
    );
  }
}