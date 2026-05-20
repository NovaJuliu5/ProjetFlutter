import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/domaine/cas_utilisation/authentification/connexion_usecase.dart';
import 'package:help_neighbor/domaine/cas_utilisation/authentification/inscription_usecase.dart';
import 'package:help_neighbor/domaine/entites/entite_utilisateur.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final connexionUseCase = ConnexionUseCase(getIt());
  final inscriptionUseCase = InscriptionUseCase(getIt());
  return AuthNotifier(connexionUseCase, inscriptionUseCase);
});

class AuthState {
  final bool isLoading;
  final EntiteUtilisateur? utilisateur;
  final Echec? erreur;
  AuthState({this.isLoading = false, this.utilisateur, this.erreur});
}

class AuthNotifier extends StateNotifier<AuthState> {
  final ConnexionUseCase _connexion;
  final InscriptionUseCase _inscription;
  AuthNotifier(this._connexion, this._inscription) : super(AuthState());

  Future<void> connexion(String email, String password) async {
    state = AuthState(isLoading: true);
    final result = await _connexion.executer(email, password);
    result.fold(
          (echec) => state = AuthState(erreur: echec),
          (utilisateur) => state = AuthState(utilisateur: utilisateur),
    );
  }

  Future<void> inscription(String email, String password, String nom, String prenom) async {
    state = AuthState(isLoading: true);
    final result = await _inscription.executer(email, password, nom, prenom);
    result.fold(
          (echec) => state = AuthState(erreur: echec),
          (utilisateur) => state = AuthState(utilisateur: utilisateur),
    );
  }

  void deconnexion() {
    state = AuthState();
  }
}