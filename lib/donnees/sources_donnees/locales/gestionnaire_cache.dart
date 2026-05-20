import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:help_neighbor/app/dependances.dart';

class GestionnaireCache {
  static Future<void> mettreEnCache(String key, dynamic data) async {
    final prefs = getIt<SharedPreferences>();
    final json = jsonEncode(data);
    await prefs.setString(key, json);
  }

  static Future<dynamic> lireCache(String key) async {
    final prefs = getIt<SharedPreferences>();
    final json = prefs.getString(key);
    if (json != null) return jsonDecode(json);
    return null;
  }
}