import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EcranProfil extends ConsumerWidget {
  final String userId;
  const EcranProfil({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Center(child: Text('Profil de l\'utilisateur : $userId')),
    );
  }
}