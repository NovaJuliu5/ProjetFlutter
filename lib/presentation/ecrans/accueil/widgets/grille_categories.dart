import 'package:flutter/material.dart';

class GrilleCategories extends StatelessWidget {
  const GrilleCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (_, i) => Container(
          width: 80,
          margin: const EdgeInsets.all(8),
          color: Colors.grey[300],
          child: Center(child: Text('Cat $i')),
        ),
      ),
    );
  }
}