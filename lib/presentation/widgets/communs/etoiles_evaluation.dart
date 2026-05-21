import 'package:flutter/material.dart';

class EtoilesEvaluation extends StatelessWidget {
  final double note;
  final double taille;
  const EtoilesEvaluation({super.key, required this.note, this.taille = 16});

  @override
  Widget build(BuildContext context) {
    int etoilesPleines = note.floor();
    bool demi = (note - etoilesPleines) >= 0.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < etoilesPleines) {
          return Icon(Icons.star, size: taille, color: Colors.amber);
        } else if (index == etoilesPleines && demi) {
          return Icon(Icons.star_half, size: taille, color: Colors.amber);
        } else {
          return Icon(Icons.star_border, size: taille, color: Colors.amber);
        }
      }),
    );
  }
}