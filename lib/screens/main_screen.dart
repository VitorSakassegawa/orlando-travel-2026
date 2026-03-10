import 'package:flutter/material.dart';
import '../orlando_theme.dart';
import 'dashboard_screen.dart';
import 'checklist_screen.dart';
import 'expenses_screen.dart';
import 'budget_screen.dart';
import 'ai_chat_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ChecklistScreen(),
    const ExpensesScreen(),
    const BudgetScreen(),
    const AIChatScreen(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Checklist',
    'Meus Gastos',
    'Orçamento',
    'Assistente IA',
  ];

  final List<IconData> _icons = [
    Icons.dashboard_rounded,
    Icons.fact_check_rounded,
    Icons.payments_rounded,
    Icons.pie_chart_rounded,
    Icons.auto_awesome_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          title: Row(
            children: [
              Text(_titles[_selectedIndex]),
              const Spacer(),
              const _SyncStatusIcon(),
            ],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _selectedIndex == 0 ? null : DecorationImage(
            image: const NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'),
            opacity: 0.05,
            colorFilter: ColorFilter.mode(OrlandoTheme.sage.withOpacity(0.1), BlendMode.srcIn),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: _selectedIndex == 0 ? 0 : 8.0, 
          ),
          child: _screens[_selectedIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Geral'),
            BottomNavigationBarItem(icon: Icon(Icons.fact_check_rounded), label: 'Checklist'),
            BottomNavigationBarItem(icon: Icon(Icons.payments_rounded), label: 'Gastos'),
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart_rounded), label: 'Budget'),
            BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_rounded), label: 'Chat IA'),
          ],
        ),
      ),
    );
  }
}

class _SyncStatusIcon extends StatelessWidget {
  const _SyncStatusIcon();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: OrlandoTheme.sage.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          const Text('SYNC', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: OrlandoTheme.muted)),
        ],
      ),
    );
  }
}
