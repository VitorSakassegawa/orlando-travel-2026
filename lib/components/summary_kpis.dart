import 'package:flutter/material.dart';
import '../orlando_theme.dart';
import 'glass_card.dart';

class SummaryKPIs extends StatelessWidget {
  const SummaryKPIs({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: const [
        _KPICard(
          label: 'GASTOS TOTAL',
          value: '\$4.250',
          color: OrlandoTheme.sage,
        ),
        _KPICard(
          label: 'A PAGAR',
          value: '\$1.120',
          color: OrlandoTheme.terracotta,
          isAlert: true,
        ),
        _KPICard(
          label: 'ECONOMIA',
          value: '12.5%',
          color: OrlandoTheme.gold,
        ),
        _KPICard(
          label: 'VOOS',
          value: 'Confirme',
          color: OrlandoTheme.sky,
        ),
      ],
    );
  }
}

class _KPICard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final bool isAlert;

  const _KPICard({
    required this.label,
    required this.value,
    required this.color,
    this.isAlert = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 2,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color, color.withOpacity(0)],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: textTheme.labelMedium?.copyWith(
              fontSize: 9,
              color: OrlandoTheme.muted,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: textTheme.displayMedium?.copyWith(
              fontSize: 18,
              color: isAlert ? OrlandoTheme.terracotta : null,
            ),
          ),
        ],
      ),
    );
  }
}
