import 'package:help_neighbor/coeur/utils/calculateur_distance.dart';

class CalculerDistanceUseCase {
  double executer(double lat1, double lon1, double lat2, double lon2) {
    return CalculateurDistance.distanceEntre(lat1, lon1, lat2, lon2);
  }
}