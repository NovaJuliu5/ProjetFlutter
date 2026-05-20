import 'package:flutter/material.dart';

class EcranDetailDemande extends StatelessWidget {
  final String id;
  const EcranDetailDemande({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail de la demande')),
      body: Center(child: Text('Demande ID: $id')),
    );
  }
}