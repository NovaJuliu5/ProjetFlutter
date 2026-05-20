import 'package:flutter/material.dart';

class EcranListeDiscussions extends StatelessWidget {
  const EcranListeDiscussions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discussions')),
      body: const Center(child: Text('Liste des discussions à venir')),
    );
  }
}