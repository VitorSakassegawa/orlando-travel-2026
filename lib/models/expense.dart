import 'dart:convert';

class Expense {
  final String id;
  final String desc;
  final double usd;
  final String date;
  final String emoji;
  final String pm; // credit, multi, cash
  final String category;
  final String paidBy;
  final List<String> splitWith;
  final double brlFinal;
  final String? invoiceImg;

  Expense({
    required this.id,
    required this.desc,
    required this.usd,
    required this.date,
    required this.emoji,
    required this.pm,
    required this.category,
    required this.paidBy,
    required this.splitWith,
    required this.brlFinal,
    this.invoiceImg,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'desc': desc,
      'usd': usd,
      'date': date,
      'emoji': emoji,
      'pm': pm,
      'category': category,
      'paid_by': paidBy,
      'split_with': splitWith,
      'brl_final': brlFinal,
      'invoice_img': invoiceImg,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'] ?? '',
      desc: map['desc'] ?? '',
      usd: (map['usd'] ?? 0.0).toDouble(),
      date: map['date'] ?? '',
      emoji: map['emoji'] ?? '🛒',
      pm: map['pm'] ?? 'credit',
      category: map['category'] ?? 'Geral',
      paidBy: map['paid_by'] ?? '',
      splitWith: List<String>.from(map['split_with'] ?? []),
      brlFinal: (map['brl_final'] ?? 0.0).toDouble(),
      invoiceImg: map['invoice_img'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) => Expense.fromMap(json.decode(source));
}
