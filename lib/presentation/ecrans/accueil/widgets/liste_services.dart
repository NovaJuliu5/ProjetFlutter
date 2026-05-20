import 'package:flutter/material.dart';
import 'package:help_neighbor/domaine/entites/entite_service.dart';

class ListeServices extends StatelessWidget {
  final List<EntiteService> services;
  const ListeServices({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Services à proximité', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...services.map((s) => ListTile(
          title: Text(s.titre),
          subtitle: Text('${s.prix} € - ${s.utilisateurNom}'),
          onTap: () => Navigator.pushNamed(context, '/service/${s.id}'),
        )),
      ],
    );
  }
}