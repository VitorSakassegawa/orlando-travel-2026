import 'dart:convert';

class BudgetCategory {
  final String name;
  final double plannedBrl;
  final double realizedBrl;
  final String emoji;

  BudgetCategory({
    required this.name,
    required this.plannedBrl,
    required this.realizedBrl,
    required this.emoji,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'planned_brl': plannedBrl,
      'realized_brl': realizedBrl,
      'emoji': emoji,
    };
  }

  factory BudgetCategory.fromMap(Map<String, dynamic> map) {
    return BudgetCategory(
      name: map['name'] ?? '',
      plannedBrl: (map['planned_brl'] ?? 0.0).toDouble(),
      realizedBrl: (map['realized_brl'] ?? 0.0).toDouble(),
      emoji: map['emoji'] ?? '💰',
    );
  }
}

class TripletBudget {
  final List<BudgetCategory> categories;
  final double exchangeRate;

  TripletBudget({
    required this.categories,
    required this.exchangeRate,
  });

  double get totalPlanned => categories.fold(0, (sum, item) => sum + item.plannedBrl);
  double get totalRealized => categories.fold(0, (sum, item) => sum + item.realizedBrl);
  double get totalEconomy => totalPlanned - totalRealized;
  double get percentUsed => totalPlanned > 0 ? (totalRealized / totalPlanned) * 100 : 0;

  Map<String, dynamic> toMap() {
    return {
      'categories': categories.map((x) => x.toMap()).toList(),
      'exchange_rate': exchangeRate,
    };
  }

  factory TripletBudget.fromMap(Map<String, dynamic> map) {
    return TripletBudget(
      categories: List<BudgetCategory>.from(
        (map['categories'] ?? []).map((x) => BudgetCategory.fromMap(x)),
      ),
      exchangeRate: (map['exchange_rate'] ?? 5.85).toDouble(),
    );
  }
}
