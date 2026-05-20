import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/services/localisation/service_localisation.dart';

final localisationProvider = FutureProvider<Position>((ref) async {
  final service = getIt<ServiceLocalisation>();
  final result = await service.obtenirPositionActuelle();
  return result.fold(
        (echec) => throw Exception(echec.message),
        (position) => position,
  );
});