import 'package:flutter/material.dart';

class BoutonPersonnalise extends StatelessWidget {
  final String texte;
  final VoidCallback onPressed;
  const BoutonPersonnalise({super.key, required this.texte, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
      child: Text(texte),
    );
  }
}