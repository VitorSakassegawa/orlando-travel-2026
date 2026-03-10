import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';
import '../orlando_theme.dart';
import '../components/glass_card.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mock data for initial state
    final List<Expense> expenses = [
      Expense(
        id: '1',
        desc: 'Best Buy - Orlando Intl',
        usd: 260.08,
        date: '2026-03-10',
        emoji: '🛒',
        pm: 'credit',
        category: 'Geral',
        paidBy: 'Vitor S.',
        splitWith: ['Vitor S.', 'Beatriz S.'],
        brlFinal: 1625.50,
      ),
      Expense(
        id: '2',
        desc: 'Shake Shack - MCO',
        usd: 42.50,
        date: '2026-03-10',
        emoji: '🍔',
        pm: 'debit',
        category: 'Alimentação',
        paidBy: 'Vitor S.',
        splitWith: ['Vitor S.', 'Beatriz S.'],
        brlFinal: 265.62,
      ),
    ];

    final double totalBrl = expenses.fold(0, (sum, i) => sum + i.brlFinal);
    const double toPayBrl = 1120.00;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'RESUMO FINANCEIRO'),
          const SizedBox(height: 8),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _buildSummaryCard(context, 'Total Grupo', 'R\$ ${totalBrl.toStringAsFixed(0)}', OrlandoTheme.sage),
              _buildToPayCard(context, toPayBrl),
            ],
          ),
          const SizedBox(height: 32),
          _SectionLabel(text: 'HISTÓRICO DE GASTOS'),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.82,
                ),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  return _buildExpenseCard(context, expenses[index]);
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String label, String value, Color color) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0)]),
            ),
          ),
          const SizedBox(height: 12),
          Text(label, style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 9, color: OrlandoTheme.muted)),
          const Spacer(),
          Text(value, style: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildToPayCard(BuildContext context, double value) {
    bool hasBalance = value > 0;
    return GlassCard(
      color: hasBalance ? OrlandoTheme.terracotta.withOpacity(0.05) : null,
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [OrlandoTheme.terracotta, OrlandoTheme.terracotta.withOpacity(0)],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('A PAGAR', style: Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: 9, color: OrlandoTheme.muted)),
              const Spacer(),
              Text('R\$ ${value.toStringAsFixed(0)}', 
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: 18, 
                  color: hasBalance ? OrlandoTheme.terracotta : null,
                ),
              ),
            ],
          ),
          if (hasBalance)
            const Positioned(
              top: 10,
              right: 0,
              child: _PulsingBadge(),
            ),
        ],
      ),
    );
  }

  Widget _buildExpenseCard(BuildContext context, Expense item) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.emoji, style: const TextStyle(fontSize: 22)),
              Text('\$${item.usd.toStringAsFixed(2)}', 
                style: const TextStyle(fontWeight: FontWeight.bold, color: OrlandoTheme.sageDark, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Text(item.desc, maxLines: 2, overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, height: 1.2)),
          const Spacer(),
          Text('R\$ ${item.brlFinal.toStringAsFixed(2)}', 
            style: const TextStyle(fontSize: 11, color: OrlandoTheme.muted, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: OrlandoTheme.sageWash,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: OrlandoTheme.sageMist),
            ),
            child: const Text('PAGO', style: TextStyle(fontSize: 9, color: OrlandoTheme.sageDark, fontWeight: FontWeight.w900, letterSpacing: 0.5)),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.labelMedium);
  }
}

class _PulsingBadge extends StatefulWidget {
  const _PulsingBadge();
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
        decoration: const BoxDecoration(color: OrlandoTheme.terracotta, shape: BoxShape.circle),
      ),
    );
  }
}
