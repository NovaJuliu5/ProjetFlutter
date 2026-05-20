import 'package:flutter/material.dart';

class IndicateurChargement extends StatelessWidget {
  const IndicateurChargement({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}