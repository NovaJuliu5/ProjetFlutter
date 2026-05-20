import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';

class ServiceLocalisation {
  Future<Either<Echec, Position>> obtenirPositionActuelle() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Left(EchecLocalisation('La localisation est désactivée'));
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Left(EchecLocalisation('Permission refusée'));
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Left(EchecLocalisation('Permission refusée définitivement'));
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      return Right(position);
    } catch (e) {
      return Left(EchecLocalisation('Erreur de géolocalisation: $e'));
    }
  }
}