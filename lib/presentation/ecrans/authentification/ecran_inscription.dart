import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart';
import 'package:help_neighbor/coeur/extensions/extensions_context.dart';
import 'package:help_neighbor/presentation/widgets/communs/champ_texte_personnalise.dart';
import 'package:help_neighbor/presentation/widgets/communs/bouton_personnalise.dart';

class EcranInscription extends ConsumerStatefulWidget {
  const EcranInscription({super.key});

  @override
  ConsumerState<EcranInscription> createState() => _EcranInscriptionState();
}

class _EcranInscriptionState extends ConsumerState<EcranInscription> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    ref.listen(authProvider, (previous, next) {
      if (next.erreur != null) {
        context.showSnackBar(next.erreur!.message, isError: true);
      }
      if (next.utilisateur != null) {
        context.go('/accueil');
      }
    });

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text('Inscription', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ChampTextePersonnalise(
                controller: _nomController,
                label: 'Nom',
                validator: (v) => v!.isNotEmpty ? null : 'Requis',
              ),
              ChampTextePersonnalise(
                controller: _prenomController,
                label: 'Prénom',
                validator: (v) => v!.isNotEmpty ? null : 'Requis',
              ),
              ChampTextePersonnalise(
                controller: _emailController,
                label: 'Email',
                validator: (v) => v!.contains('@') ? null : 'Email invalide',
              ),
              ChampTextePersonnalise(
                controller: _passwordController,
                label: 'Mot de passe',
                obscureText: true,
                validator: (v) => v!.length >= 6 ? null : '6 caractères min',
              ),
              const SizedBox(height: 24),
              if (authState.isLoading) const CircularProgressIndicator()
              else BoutonPersonnalise(
                texte: 'S\'inscrire',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ref.read(authProvider.notifier).inscription(
                      _emailController.text,
                      _passwordController.text,
                      _nomController.text,
                      _prenomController.text,
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('Déjà un compte ? Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}