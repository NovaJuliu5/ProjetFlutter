import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:help_neighbor/donnees/sources_donnees/distantes/client_api.dart';
import 'package:help_neighbor/donnees/depots/depot_authentification.dart';
import 'package:help_neighbor/donnees/depots/depot_utilisateur.dart';
import 'package:help_neighbor/donnees/depots/depot_service.dart';
import 'package:help_neighbor/donnees/depots/depot_demande.dart';
import 'package:help_neighbor/donnees/depots/depot_discussion.dart';
import 'package:help_neighbor/services/localisation/service_localisation.dart';

final getIt = GetIt.instance;

Future<void> initDependances() async {
  final sharedPrefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPrefs);
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  getIt.registerSingleton<ClientApi>(ClientApi());
  getIt.registerSingleton<DepotAuthentification>(DepotAuthentification(getIt()));
  getIt.registerSingleton<DepotUtilisateur>(DepotUtilisateur(getIt()));
  getIt.registerSingleton<DepotService>(DepotService(getIt()));
  getIt.registerSingleton<DepotDemande>(DepotDemande(getIt()));
  getIt.registerSingleton<DepotDiscussion>(DepotDiscussion(getIt()));
  getIt.registerSingleton<ServiceLocalisation>(ServiceLocalisation());
}