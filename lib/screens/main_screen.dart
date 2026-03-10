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
              _SyncStatusIcon(),
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
            top: _selectedIndex == 0 ? 0 : 8.0, // Correction #1: 8px gap
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
