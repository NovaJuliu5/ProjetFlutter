import 'package:go_router/go_router.dart';
import 'package:help_neighbor/presentation/ecrans/authentification/ecran_connexion.dart';
import 'package:help_neighbor/presentation/ecrans/authentification/ecran_inscription.dart';
import 'package:help_neighbor/presentation/ecrans/accueil/ecran_accueil.dart';
import 'package:help_neighbor/presentation/ecrans/service/ecran_detail_service.dart';
import 'package:help_neighbor/presentation/ecrans/demande/ecran_detail_demande.dart';
import 'package:help_neighbor/presentation/ecrans/discussion/ecran_liste_discussions.dart';
import 'package:help_neighbor/presentation/ecrans/profil/ecran_profil.dart';

import '../presentation/ecrans/demande/ecran_creer_demande.dart';
import '../presentation/ecrans/explorer/ecran_explorer.dart';
import '../presentation/ecrans/notifications/ecran_notifications.dart';

final router = GoRouter(
  initialLocation: '/connexion',
  routes: [
    GoRoute(
      path: '/connexion',
      name: 'connexion',
      builder: (context, state) => const EcranConnexion(),
    ),
    GoRoute(
      path: '/inscription',
      name: 'inscription',
      builder: (context, state) => const EcranInscription(),
    ),
    GoRoute(
      path: '/accueil',
      name: 'accueil',
      builder: (context, state) => const EcranAccueil(),
    ),
    GoRoute(
      path: '/service/:id',
      name: 'service_detail',
      builder: (context, state) => EcranDetailService(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/demande/:id',
      name: 'demande_detail',
      builder: (context, state) => EcranDetailDemande(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/explorer',
      name: 'explorer',
      builder: (context, state) => const EcranExplorer(),
    ),
    GoRoute(
      path: '/creer-demande',
      name: 'creer_demande',
      builder: (context, state) => const EcranCreerDemande(),
    ),
    GoRoute(
      path: '/notifications',
      name: 'notifications',
      builder: (context, state) => const EcranNotifications(),
    ),
    GoRoute(
      path: '/discussions',
      name: 'discussions',
      builder: (context, state) => const EcranListeDiscussions(),
    ),
    GoRoute(
      path: '/profil/:id',
      name: 'profil',
      builder: (context, state) => EcranProfil(userId: state.pathParameters['id']!),
    ),
  ],
);