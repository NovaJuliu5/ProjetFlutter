import 'package:shared_preferences/shared_preferences.dart';
import 'package:help_neighbor/app/dependances.dart';

class AidePreferences {
  static Future<void> sauvegarderToken(String token) async {
    final prefs = getIt<SharedPreferences>();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> recupererToken() async {
    final prefs = getIt<SharedPreferences>();
    return prefs.getString('auth_token');
  }

  static Future<void> effacerToken() async {
    final prefs = getIt<SharedPreferences>();
    await prefs.remove('auth_token');
  }
}