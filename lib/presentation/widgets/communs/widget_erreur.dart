import 'package:flutter/material.dart';

class WidgetErreur extends StatelessWidget {
  final String message;
  const WidgetErreur({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Erreur: $message'));
  }
}