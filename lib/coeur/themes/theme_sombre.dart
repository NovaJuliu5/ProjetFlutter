import 'package:flutter/material.dart';
import 'package:help_neighbor/coeur/themes/styles_texte.dart';

class ThemeSombre {
  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      primaryColor: Colors.green[300],
      scaffoldBackgroundColor: Colors.grey[900],
      textTheme: StylesTexte.textThemeSombre,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}