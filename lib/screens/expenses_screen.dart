import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';
import 'dart:math' as math;

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for initial state
    final List<Expense> expenses = [
      Expense(
        id: '1',
        desc: 'Best Buy - Las Vegas',
        usd: 260.08,
        date: '2026-03-10',
        emoji: '🛒',
        pm: 'credit',
        category: 'Geral',
        paidBy: 'Vitor S.',
        splitWith: ['Vitor S.', 'Beatriz S.'],
        brlFinal: 1625.50,
      ),
    ];

    final double totalBrl = expenses.fold(0, (sum, i) => sum + i.brlFinal);
    final double paidBrl = totalBrl; // simplified for mock
    final double toPayBrl = 0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Correction #5: 2x2 Compact Grid Summary
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.8,
            children: [
              _buildSummaryCard('Total Grupo', 'R\$ ${totalBrl.toStringAsFixed(0)}', Colors.grey.shade100, Colors.black),
              _buildSummaryCard('Dólar Médio', 'R\$ 5.85', Colors.grey.shade100, Colors.black),
              _buildSummaryCard('Pago', 'R\$ ${paidBrl.toStringAsFixed(0)}', Colors.green.shade50, Colors.green.shade800),
              _buildToPayCard(toPayBrl), // Correction #5: Pulsing badge if > 0
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Histórico de Gastos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          // Correction #2: Responsive grid for items
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final item = expenses[index];
                  return _buildExpenseCard(item);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String label, String value, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: textCol)),
        ],
      ),
    );
  }

  Widget _buildToPayCard(double value) {
    bool hasBalance = value > 0;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: hasBalance ? Colors.orange.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: hasBalance ? Colors.orange.shade200 : Colors.black.withOpacity(0.05)),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('A Pagar', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey)),
              const Spacer(),
              Text('R\$ ${value.toStringAsFixed(0)}', 
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: hasBalance ? Colors.orange.shade900 : Colors.black)),
            ],
          ),
          if (hasBalance)
            Positioned(
              top: -2,
              right: -2,
              child: _PulsingBadge(),
            ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(Expense item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item.emoji, style: const TextStyle(fontSize: 20)),
                Text('\$${item.usd}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
              ],
            ),
            const SizedBox(height: 4),
            Text(item.desc, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const Spacer(),
            Text('R\$ ${item.brlFinal.toStringAsFixed(2)}', 
              style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w600)),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
              child: const Text('PAGO', style: TextStyle(fontSize: 9, color: Colors.green, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingBadge extends StatefulWidget {
  @override
  __PulsingBadgeState createState() => __PulsingBadgeState();
}

class __PulsingBadgeState extends State<_PulsingBadge> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.2).animate(_controller),
      child: Container(
        width: 10,
        height: 10,
        decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
      ),
    );
  }
}
