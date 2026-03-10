import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/budget.dart';

final budgetCategoryProvider = StateProvider<String>((ref) => 'Passagens');

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(budgetCategoryProvider);

    // Mock data based on screenshots/request
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
    final bool isOver = mockBudget.totalRealized > mockBudget.totalPlanned;
    final double diff = (mockBudget.totalEconomy / mockBudget.totalPlanned * 100).abs();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Correction #3: Park Dropdown Selection
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF3F5E42),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedCategory,
                dropdownColor: const Color(0xFF3F5E42),
                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                items: mockBudget.categories.map((c) {
                  return DropdownMenuItem(
                    value: c.name,
                    child: Text('${c.emoji} ${c.name}'),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) ref.read(budgetCategoryProvider.notifier).state = val;
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Correction #2: Budget Visuals (Economy/Overage)
          _buildBudgetInsight(mockBudget),
          const SizedBox(height: 20),
          _buildDetailCard(currentCategory),
        ],
      ),
    );
  }

  Widget _buildBudgetInsight(TripletBudget budget) {
    final bool isOver = budget.totalRealized > budget.totalPlanned;
    final double percent = budget.totalPlanned > 0 ? (budget.totalRealized / budget.totalPlanned) : 0;
    final double economyPercent = ((budget.totalPlanned - budget.totalRealized) / budget.totalPlanned * 100);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isOver ? Colors.red.shade50 : Colors.green.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isOver ? Colors.red.shade200 : Colors.green.shade200),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TOTAL PLANEJADO', style: TextStyle(fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold, color: Colors.grey)),
                  Text('R\$ ${budget.totalPlanned.toStringAsFixed(2)}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isOver ? Colors.red : Colors.green.shade600,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Text(
                  isOver ? '❌ Ultrapassado em ${percent.toStringAsFixed(0)}%' : '✅ Economia de ${economyPercent.toStringAsFixed(1)}%',
                  style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Correction #2: Colored Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: LinearProgressIndicator(
              value: percent.clamp(0, 1),
              minHeight: 12,
              backgroundColor: Colors.black.withOpacity(0.05),
              valueColor: AlwaysStoppedAnimation<Color>(
                percent > 0.9 ? Colors.red : (percent > 0.7 ? Colors.orange : Colors.green),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Realizado: R\$ ${budget.totalRealized.toStringAsFixed(2)}', style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold)),
              Text('${(percent * 100).toStringAsFixed(0)}%', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(BudgetCategory item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(12)),
                  child: Text(item.emoji, style: const TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('Detalhamento da categoria', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildRow('Planejado', 'R\$ ${item.plannedBrl.toStringAsFixed(2)}', Colors.black),
            _buildRow('Realizado', 'R\$ ${item.realizedBrl.toStringAsFixed(2)}', Colors.green.shade700),
            const Divider(),
            _buildRow('Saldo', 'R\$ ${(item.plannedBrl - item.realizedBrl).toStringAsFixed(2)}', Colors.blue),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String val, Color col) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          Text(val, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: col)),
        ],
      ),
    );
  }
}
