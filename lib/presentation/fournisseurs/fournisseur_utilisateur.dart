import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/domaine/entites/entite_utilisateur.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/donnees/depots/depot_utilisateur.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart';

final profilUtilisateurProvider = FutureProvider<EntiteUtilisateur>((ref) async {
  final authState = ref.watch(authProvider);
  final utilisateurId = authState.utilisateur?.id;
  if (utilisateurId == null) throw Exception('Non connecté');
  final depot = getIt<DepotUtilisateur>();
  final result = await depot.obtenirProfil(utilisateurId);
  return result.fold(
        (echec) => throw Exception(echec.message),
        (utilisateur) => utilisateur,
  );
});