import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:help_neighbor/app/routes.dart';
import 'package:help_neighbor/coeur/themes/theme_app.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_theme.dart';
import 'package:help_neighbor/app/routes.dart';


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Help Neighbor',
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.themeClair,
      darkTheme: ThemeApp.themeSombre,
      themeMode: themeMode,
      routerConfig: router,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fr'), Locale('en')],
    );
  }
}