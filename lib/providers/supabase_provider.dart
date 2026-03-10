import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';

final supabaseClientProvider = Provider((ref) => Supabase.instance.client);

// Provider for real-time expenses
final expensesStreamProvider = StreamProvider<List<Expense>>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return client
      .from('sync_data')
      .stream(primaryKey: ['key', 'user_id'])
      .eq('key', 'orlando2026_gastos_v2')
      .map((data) {
        if (data.isEmpty) return [];
        // The value is stored as a JSON string in the 'value' column
        final String rawJson = data.first['value'] as String;
        final List<dynamic> list = jsonDecode(rawJson);
        return list.map((e) => Expense.fromMap(e)).toList();
      });
});

// Function to save expense and sync
final saveExpenseProvider = Provider((ref) {
  final client = ref.watch(supabaseClientProvider);
  
  return (Expense expense) async {
    // 1. Load current items
    // 2. Add new item
    // 3. Upsert to Supabase
    // This is a simplified version of the sync logic from index.html
    await client.from('sync_data').upsert({
      'key': 'orlando2026_gastos_v2',
      'value': '[...]', // In a real app, we would merge and stringify
      'user_id': 'group',
      'updated_at': DateTime.now().toIso8601String(),
    });
  };
});
