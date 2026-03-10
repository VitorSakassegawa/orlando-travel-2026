import 'package:flutter/material.dart';
import '../components/hero_section.dart';
import '../components/weather_card.dart';
import '../components/summary_kpis.dart';
import '../components/glass_card.dart';
import '../orlando_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeroSection(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const WeatherCard(),
                const SizedBox(height: 24),
                _SectionHeader(title: 'Resumo da Viagem', action: 'Ver tudo'),
                const SizedBox(height: 12),
                const SummaryKPIs(),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Próximos Passos', action: 'Calendário'),
                const SizedBox(height: 12),
                _buildTimeline(context),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Dicas de Hoje', action: 'Hacks'),
                const SizedBox(height: 12),
                _buildDailyTip(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final List<Map<String, String>> timeline = [
      {'day': '04/04', 'event': 'Voo GRU → BSB → MCO', 'time': '06:00', 'tag': 'VIAGEM'},
      {'day': '05/04', 'event': 'Páscoa no The Loop & Outlet', 'time': '09:00', 'tag': 'COMPRAS'},
      {'day': '06/04', 'event': 'EPCOT (Early Entry 08:30)', 'time': '08:30', 'tag': 'PARQUE'},
    ];

    return Column(
      children: timeline.map((item) => _TimelineItem(
        day: item['day']!,
        event: item['event']!,
        time: item['time']!,
        tag: item['tag']!,
        isLast: timeline.last == item,
      )).toList(),
    );
  }

  Widget _buildDailyTip(BuildContext context) {
    return GlassCard(
      color: OrlandoTheme.sky.withOpacity(0.1),
      child: Row(
        children: [
          const Text('💡', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('DICA DE OURO', style: Theme.of(context).textTheme.labelMedium?.copyWith(color: OrlandoTheme.sky)),
                const SizedBox(height: 4),
                const Text(
                  'Divida o grupo no Walmart para agilizar a primeira noite. Foque em água e snacks!',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String day;
  final String event;
  final String time;
  final String tag;
  final bool isLast;

  const _TimelineItem({
    required this.day,
    required this.event,
    required this.time,
    required this.tag,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TimelinePreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: OrlandoTheme.sageWash.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: OrlandoTheme.sageMist),
      ),
      child: const Row(
        children: [
          Text('🎡', style: TextStyle(fontSize: 24)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Universal Studios',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  'Amanhã • Inteiro • Cansaço Baixo',
                  style: TextStyle(color: OrlandoTheme.muted, fontSize: 12),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: OrlandoTheme.muted),
        ],
      ),
    );
  }
}
