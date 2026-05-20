import 'package:flutter/material.dart';
import 'package:help_neighbor/domaine/entites/entite_demande.dart';

class ListeDemandes extends StatelessWidget {
  final List<EntiteDemande> demandes;
  const ListeDemandes({super.key, required this.demandes});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Demandes récentes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        ...demandes.map((d) => ListTile(
          title: Text(d.titre),
          subtitle: Text('Statut: ${d.statut} - ${d.utilisateurNom}'),
          onTap: () => Navigator.pushNamed(context, '/demande/${d.id}'),
        )),
      ],
    );
  }
}