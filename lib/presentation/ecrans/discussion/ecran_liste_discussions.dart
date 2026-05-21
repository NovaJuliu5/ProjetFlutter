import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_conversation.dart';
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';
import 'package:help_neighbor/presentation/widgets/communs/indicateur_chargement.dart';
import 'package:help_neighbor/presentation/widgets/communs/widget_erreur.dart';

class EcranListeDiscussions extends ConsumerWidget {
  const EcranListeDiscussions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversationsAsync = ref.watch(conversationListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: conversationsAsync.when(
        data: (conversations) {
          if (conversations.isEmpty) {
            return const Center(child: Text('Aucune discussion'));
          }
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conv = conversations[index];
              return ListTile(
                leading: CircleAvatar(child: Text(conv.autreNom.isNotEmpty ? conv.autreNom[0] : '?')),
                title: Text(conv.autreNom),
                subtitle: Text(conv.dernierMessage ?? 'Nouvelle conversation'),
                trailing: conv.derniereActivite != null
                    ? Text(_formatDate(conv.derniereActivite!))
                    : null,
                onTap: () => context.push('/discussion/${conv.id}', extra: {'autreNom': conv.autreNom, 'autreId': conv.autreId}),
              );
            },
          );
        },
        loading: () => const IndicateurChargement(),
        error: (err, _) => WidgetErreur(message: err.toString()),
      ),
      bottomNavigationBar: const BarreNavigationBasPersonnalisee(selectedIndex: 3),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    if (date.day == now.day && date.month == now.month && date.year == now.year) {
      return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
    return '${date.day}/${date.month}';
  }
}