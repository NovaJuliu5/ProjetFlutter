import 'package:flutter/material.dart';
import 'package:help_neighbor/coeur/themes/styles_texte.dart';

class ThemeClair {
  static ThemeData theme() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.green,
      primaryColor: Colors.green[700],
      scaffoldBackgroundColor: Colors.grey[50],
      textTheme: StylesTexte.textThemeClair,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}