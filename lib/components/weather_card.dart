import 'package:flutter/material.dart';
import '../orlando_theme.dart';
import 'glass_card.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      color: OrlandoTheme.sky.withOpacity(0.1),
      padding: const EdgeInsets.all(22),
      child: Row(
        children: [
          const Text(
            '☀️', // Localized weather icon
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Céu Limpo em Orlando',
                  style: textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                Text(
                  'Agora: 24°C | Máx: 28°C',
                  style: textTheme.bodySmall?.copyWith(color: OrlandoTheme.muted),
                ),
                const SizedBox(height: 10),
                const Wrap(
                  spacing: 8,
                  children: [
                    _WeatherTag(label: 'Umidade: 45%'),
                    _WeatherTag(label: 'Vento: 12km/h'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WeatherTag extends StatelessWidget {
  final String label;
  const _WeatherTag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: OrlandoTheme.sky.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: OrlandoTheme.sky,
        ),
      ),
    );
  }
}
