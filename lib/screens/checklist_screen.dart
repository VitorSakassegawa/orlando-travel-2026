import 'package:flutter/material.dart';
import '../components/glass_card.dart';
import '../orlando_theme.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
          color: done ? Colors.grey : null,
        )),
        value: done,
        onChanged: (v) {},
        activeColor: const Color(0xFF3F5E42),
      ),
    );
  }
}
