import 'package:dio/dio.dart';
import 'package:help_neighbor/coeur/erreurs/echec.dart';

class GestionnaireErreurs {
  static Echec traiterErreur(dynamic error) {
    if (error is DioException) {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.connectionError) {
        return const EchecReseau();
      }
      if (error.response?.statusCode == 401) {
        return EchecAuthentification('Session expirée');
      }
      return EchecServeur(error.message ?? 'Erreur serveur');
    }
    return EchecServeur(error.toString());
  }
}