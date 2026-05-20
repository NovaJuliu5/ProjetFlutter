import 'package:flutter/material.dart';

class EnTeteAccueil extends StatelessWidget {
  const EnTeteAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Help Neighbor'),
      pinned: true,
    );
  }
}