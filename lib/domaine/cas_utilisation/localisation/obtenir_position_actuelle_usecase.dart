import 'package:help_neighbor/coeur/utils/resultat.dart';
import 'package:help_neighbor/services/localisation/service_localisation.dart';
import 'package:geolocator/geolocator.dart';

class ObtenirPositionActuelleUseCase {
  final ServiceLocalisation service;
  ObtenirPositionActuelleUseCase(this.service);

  Future<Resultat<Position>> executer() async {
    return await service.obtenirPositionActuelle();
  }
}