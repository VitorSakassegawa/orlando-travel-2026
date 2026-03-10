import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../orlando_theme.dart';
import '../components/glass_card.dart';

class AIChatScreen extends HookWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final List<Map<String, String>> messages = [
      {'role': 'ai', 'text': 'Olá! Sou seu MagicGuide. ✨ Como posso ajudar com sua viagem para Orlando?'},
      {'role': 'user', 'text': 'Qual o melhor horário para ir no Harry Potter?'},
      {'role': 'ai', 'text': 'Recomendo ir logo na abertura ou 1h antes de fechar o parque. As filas costumam baixar bastante! 🎢'},
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isAi = msg['role'] == 'ai';
              return _ChatBubble(text: msg['text']!, isAi: isAi);
            },
          ),
        ),
        _buildInputArea(controller),
      ],
    );
  }

  Widget _buildInputArea(TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      decoration: BoxDecoration(
        color: OrlandoTheme.paper.withOpacity(0.8),
        border: Border(top: BorderSide(color: OrlandoTheme.sand.withOpacity(0.5))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: GlassCard(
              padding: EdgeInsets.zero,
              borderRadius: 16,
              color: Colors.white,
              child: TextField(
                controller: controller,
                maxLines: null,
                minLines: 1,
                decoration: InputDecoration(
                  hintText: 'Pergunte algo...',
                  hintStyle: const TextStyle(color: OrlandoTheme.muted, fontSize: 14),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(fontSize: 14, color: OrlandoTheme.ink),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            margin: const EdgeInsets.only(bottom: 4),
            child: FloatingActionButton.small(
              onPressed: () {},
              elevation: 0,
              backgroundColor: OrlandoTheme.sageDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isAi;
  const _ChatBubble({required this.text, required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isAi ? Colors.white : OrlandoTheme.sageDark,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isAi ? 0 : 16),
            bottomRight: Radius.circular(isAi ? 16 : 0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isAi ? OrlandoTheme.ink : Colors.white,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
