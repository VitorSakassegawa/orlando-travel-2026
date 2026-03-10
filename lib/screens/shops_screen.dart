import 'package:flutter/material.dart';
import '../orlando_theme.dart';
import '../components/glass_card.dart';

class ShopsScreen extends StatelessWidget {
  const ShopsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'COMPRAS E OUTLETS'),
          const SizedBox(height: 8),
          Text('Guia de Compras', style: textTheme.displayMedium?.copyWith(fontSize: 24)),
          const SizedBox(height: 20),
          
          _ShopCard(
            name: 'Premium Outlets (Vineland)',
            desc: 'O melhor para marcas de luxo e boutiques. Menos lotado que o International Drive.',
            icon: '🛍️',
            color: OrlandoTheme.sageWash,
          ),
          
          _ShopCard(
            name: 'Premium Outlets (Intl. Drive)',
            desc: 'O maior outlet de Orlando. Ótimo para Nike, Adidas e marcas populares.',
            icon: '👟',
            color: OrlandoTheme.sky.withOpacity(0.1),
          ),

          _ShopCard(
            name: 'Walmart Supercenter',
            desc: 'Essencial para comes e bebes, e lembranças baratas da Disney.',
            icon: '🛒',
            color: OrlandoTheme.sand.withOpacity(0.3),
          ),

          _ShopCard(
            name: 'The Florida Mall',
            desc: 'Shopping fechado. Ótimo para Apple, Macy\'s e M&M\'s World.',
            icon: '📱',
            color: Colors.purple.shade50,
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

class _ShopCard extends StatelessWidget {
  final String name;
  final String desc;
  final String icon;
  final Color color;

  const _ShopCard({
    required this.name,
    required this.desc,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      color: color,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(14),
            ),
            alignment: Alignment.center,
            child: Text(icon, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: textTheme.bodySmall?.copyWith(color: OrlandoTheme.inkSoft, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
