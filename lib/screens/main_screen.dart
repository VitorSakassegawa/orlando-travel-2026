import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'checklist_screen.dart';
import 'ai_chat_screen.dart';
import 'expenses_screen.dart';
import 'budget_screen.dart';
import '../orlando_theme.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 2); // Start at Expenses (gs)

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    final List<Widget> screens = [
      const ChecklistScreen(),
      const AIChatScreen(),
      const ExpensesScreen(),
      const BudgetScreen(),
    ];

    final List<String> titles = [
      'Checklist',
      'Assistente IA',
      'Meus Gastos',
      'Orçamento',
    ];

    final List<String> emojis = ['📋', '🪄', '💳', '📊'];

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60), // Correction #1: 60px height
        child: AppBar(
          title: Row(
            children: [
              Text(emojis[selectedIndex], style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                titles[selectedIndex],
                style: OrlandoTheme.lightTheme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              // Sync Status Icon
              Icon(Icons.sync, color: Colors.green.shade400, size: 20),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8), // Correction #1: 8px gap
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: screens,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => ref.read(navigationIndexProvider.notifier).state = index,
        items: const [
          BottomNavigationBarItem(icon: Text('📋', style: TextStyle(fontSize: 20)), label: 'Checklist'),
          BottomNavigationBarItem(icon: Text('🪄', style: TextStyle(fontSize: 20)), label: 'IA'),
          BottomNavigationBarItem(icon: Text('💳', style: TextStyle(fontSize: 20)), label: 'Gastos'),
          BottomNavigationBarItem(icon: Text('📊', style: TextStyle(fontSize: 20)), label: 'Orçamento'),
        ],
      ),
    );
  }
}
