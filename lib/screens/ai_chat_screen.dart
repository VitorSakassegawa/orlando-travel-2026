import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AIChatScreen extends HookWidget {
  const AIChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final List<Map<String, String>> messages = [
      {'role': 'ai', 'text': 'Olá! Sou seu MagicGuide. Como posso ajudar com sua viagem para Orlando?'},
      {'role': 'user', 'text': 'Qual o melhor horário para ir no Harry Potter?'},
      {'role': 'ai', 'text': 'Recomendo ir logo na abertura ou 1h antes de fechar o parque. As filas costumam baixar bastante!'},
    ];

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isAi = msg['role'] == 'ai';
              return Align(
                alignment: isAi ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 16), // Correction #4: More space below bubbles
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                  decoration: BoxDecoration(
                    color: isAi ? Colors.white : const Color(0xFF3F5E42),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)],
                  ),
                  child: Text(
                    msg['text']!,
                    style: TextStyle(color: isAi ? Colors.black : Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
        // Correction #4: Flexible Input
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE3DDD2))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: null, // Flexible height
                  minLines: 3,    // ~80px min height
                  decoration: InputDecoration(
                    hintText: 'Pergunte algo...',
                    contentPadding: const EdgeInsets.all(12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE3DDD2)),
                    ),
                  ),
                  scrollPhysics: const BouncingScrollPhysics(),
                  onChanged: (v) {
                    // Update state if needed, but TextField with maxLines: null handles height
                  },
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Icons.send),
                style: IconButton.styleFrom(backgroundColor: const Color(0xFF3F5E42)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
