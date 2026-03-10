import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/budget.dart';
import '../orlando_theme.dart';
import '../components/glass_card.dart';

final budgetCategoryProvider = StateProvider<String>((ref) => 'Passagens');

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(budgetCategoryProvider);

    final mockBudget = TripletBudget(
      exchangeRate: 5.85,
      categories: [
        BudgetCategory(name: 'Passagens', plannedBrl: 2909.28, realizedBrl: 1625.50, emoji: '✈️'),
        BudgetCategory(name: 'Alimentação', plannedBrl: 4042.50, realizedBrl: 0, emoji: '🍔'),
        BudgetCategory(name: 'Hospedagem', plannedBrl: 2347.07, realizedBrl: 0, emoji: '🏨'),
        BudgetCategory(name: 'Carros', plannedBrl: 643.92, realizedBrl: 0, emoji: '🚗'),
        BudgetCategory(name: 'NBA', plannedBrl: 432.73, realizedBrl: 0, emoji: '🏀'),
        BudgetCategory(name: 'Furacão', plannedBrl: 2194.50, realizedBrl: 0, emoji: '🌀'),
      ],
    );

    final currentCategory = mockBudget.categories.firstWhere((e) => e.name == selectedCategory);
    final double percent = mockBudget.totalPlanned > 0 ? (mockBudget.totalRealized / mockBudget.totalPlanned) : 0;
    final bool isOver = mockBudget.totalRealized > mockBudget.totalPlanned;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBudgetHero(context, mockBudget, percent, isOver),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SectionLabel(text: 'DETALHAMENTO POR CATEGORIA'),
                const SizedBox(height: 12),
                _buildCategorySelector(ref, mockBudget, selectedCategory),
                const SizedBox(height: 20),
                _buildDetailCard(context, currentCategory),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetHero(BuildContext context, TripletBudget budget, double percent, bool isOver) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 32),
      decoration: const BoxDecoration(
        color: OrlandoTheme.sageDark,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF344F36), Color(0xFF1A1F16)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ORÇAMENTO TOTAL', style: textTheme.labelMedium?.copyWith(color: OrlandoTheme.sageLight, fontSize: 10)),
          const SizedBox(height: 8),
          Text(
            'R\$ ${budget.totalPlanned.toStringAsFixed(2)}',
            style: textTheme.displayLarge?.copyWith(color: Colors.white, fontSize: 40),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isOver ? '❌ Ultrapassado' : '✅ Economia de ${(100 - percent * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  color: isOver ? OrlandoTheme.terracotta : OrlandoTheme.sageLight,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                '${(percent * 100).toStringAsFixed(0)}%',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: percent.clamp(0, 1),
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation<Color>(
                isOver ? OrlandoTheme.terracotta : OrlandoTheme.sageLight,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildHeroStat('Realizado', 'R\$ ${budget.totalRealized.toStringAsFixed(2)}'),
              const SizedBox(width: 32),
              _buildHeroStat('Dólar Médio', 'R\$ ${budget.exchangeRate.toStringAsFixed(2)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCategorySelector(WidgetRef ref, TripletBudget budget, String selected) {
    return Container(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: budget.categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final cat = budget.categories[index];
          final isSelected = cat.name == selected;
          return InkWell(
            onTap: () => ref.read(budgetCategoryProvider.notifier).state = cat.name,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? OrlandoTheme.sageDark : Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isSelected ? OrlandoTheme.sageDark : OrlandoTheme.sand),
              ),
              alignment: Alignment.center,
              child: Text(
                '${cat.emoji} ${cat.name}',
                style: TextStyle(
                  color: isSelected ? Colors.white : OrlandoTheme.ink,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard(BuildContext context, BudgetCategory item) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: OrlandoTheme.sageWash, borderRadius: BorderRadius.circular(12)),
                child: Text(item.emoji, style: const TextStyle(fontSize: 24)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Text('Detalhamento da categoria', style: TextStyle(fontSize: 12, color: OrlandoTheme.muted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildRow('Planejado', 'R\$ ${item.plannedBrl.toStringAsFixed(2)}', OrlandoTheme.ink),
          _buildRow('Realizado', 'R\$ ${item.realizedBrl.toStringAsFixed(2)}', OrlandoTheme.sageDark),
          const Divider(height: 32, color: OrlandoTheme.sand),
          _buildRow('Saldo Restante', 'R\$ ${(item.plannedBrl - item.realizedBrl).toStringAsFixed(2)}', OrlandoTheme.sky),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String val, Color col) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: OrlandoTheme.muted, fontWeight: FontWeight.w500)),
          Text(val, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: col)),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(text, style: const TextStyle(fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold, color: OrlandoTheme.muted));
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
