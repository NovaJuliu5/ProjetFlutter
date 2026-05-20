import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/app/app.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/config/environnement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Environnement.init();
  await initDependances();
  runApp(const ProviderScope(child: MyApp()));
}