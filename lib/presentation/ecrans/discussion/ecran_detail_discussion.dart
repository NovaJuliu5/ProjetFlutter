import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:help_neighbor/app/dependances.dart';
import 'package:help_neighbor/coeur/extensions/extensions_context.dart';
import 'package:help_neighbor/donnees/depots/depot_conversation.dart';
import 'package:help_neighbor/domaine/entites/entite_message.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_conversation.dart';
import 'package:help_neighbor/presentation/fournisseurs/fournisseur_authentification.dart'; // IMPORT CORRIGÉ
import 'package:help_neighbor/presentation/widgets/communs/barre_navigation_bas_personnalisee.dart';

class EcranDetailDiscussion extends ConsumerStatefulWidget {
  final String conversationId;
  final String autreNom;
  const EcranDetailDiscussion({super.key, required this.conversationId, required this.autreNom});

  @override
  ConsumerState<EcranDetailDiscussion> createState() => _EcranDetailDiscussionState();
}

class _EcranDetailDiscussionState extends ConsumerState<EcranDetailDiscussion> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _marquerCommeLu();
  }

  Future<void> _marquerCommeLu() async {
    final depot = getIt<DepotConversation>();
    await depot.marquerCommeLu(widget.conversationId);
  }

  Future<void> _envoyerMessage() async {
    if (_messageController.text.trim().isEmpty) return;
    setState(() => _isSending = true);
    final depot = getIt<DepotConversation>();
    final result = await depot.envoyerMessage(widget.conversationId, _messageController.text);
    setState(() => _isSending = false);
    result.fold(
          (echec) => context.showSnackBar(echec.message, isError: true),
          (_) {
        _messageController.clear();
        ref.invalidate(conversationMessagesProvider(widget.conversationId));
        _scrollToBottom();
      },
    );
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(conversationMessagesProvider(widget.conversationId));

    return Scaffold(
      appBar: AppBar(title: Text(widget.autreNom)),
      body: Column(
        children: [
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final authState = ref.read(authProvider);
                    final isMine = msg.expediteurId == authState.utilisateur?.id;
                    return _MessageBubble(message: msg, isMine: isMine);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(child: Text('Erreur: $err')),
            ),
          ),
          _buildInputBar(),
        ],
      ),
      bottomNavigationBar: BarreNavigationBasPersonnalisee(selectedIndex: 3), // const retiré
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Votre message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: _isSending ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.send),
            onPressed: _isSending ? null : _envoyerMessage,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}

class _MessageBubble extends StatelessWidget {
  final EntiteMessage message;
  final bool isMine;
  const _MessageBubble({required this.message, required this.isMine});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isMine ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMine)
              Text(message.expediteurNom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text(message.contenu),
            const SizedBox(height: 4),
            Text(
              _formatTime(message.createdAt),
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }
}