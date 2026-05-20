import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

class ServiceNavigation {
  static void goToConnexion(BuildContext context) => context.go('/connexion');
  static void goToAccueil(BuildContext context) => context.go('/accueil');
}