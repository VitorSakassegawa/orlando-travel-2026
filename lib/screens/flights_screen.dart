import 'package:flutter/material.dart';
import '../orlando_theme.dart';
import '../components/glass_card.dart';

class FlightsScreen extends StatelessWidget {
  const FlightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'VOOS E TRANSPORTE'),
          const SizedBox(height: 8),
          Text('Logística da Viagem', style: textTheme.displayMedium?.copyWith(fontSize: 24)),
          const SizedBox(height: 20),
          
          // Flight Card
          _FlightCard(
            type: 'flight',
            dir: 'IDA: GRU → MCO',
            code: 'JJ8048',
            details: [
              'Partida: **14 Abr • 22:50** (GRU)',
              'Chegada: **15 Abr • 07:10** (MCO)',
              'Assentos: **24A, 24B, 24C**',
            ],
            icon: Icons.flight_takeoff_rounded,
            color: Colors.purple.shade50,
          ),
          
          _FlightCard(
            type: 'stay',
            dir: 'HOSPEDAGEM: Kissimmee',
            code: 'AIRBNB',
            details: [
              'Check-in: **15 Abr • 16:00**',
              'Check-out: **29 Abr • 10:00**',
              'Endereço: **Champions Gate Res.**',
            ],
            icon: Icons.hotel_rounded,
            color: OrlandoTheme.sageWash,
          ),

          _FlightCard(
            type: 'car',
            dir: 'ALUGUEL: SUV 7 Lugares',
            code: 'HERTZ',
            details: [
              'Retirada: **15 Abr (Aero MCO)**',
              'Devolução: **29 Abr (Aero MCO)**',
              'Modelo: **Chevrolet Tahoe ou sim.**',
            ],
            icon: Icons.directions_car_rounded,
            color: OrlandoTheme.sky.withOpacity(0.1),
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

class _FlightCard extends StatelessWidget {
  final String type;
  final String dir;
  final String code;
  final List<String> details;
  final IconData icon;
  final Color color;

  const _FlightCard({
    required this.type,
    required this.dir,
    required this.code,
    required this.details,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GlassCard(
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: OrlandoTheme.ink),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dir, style: textTheme.titleSmall),
                    const SizedBox(height: 2),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: OrlandoTheme.sageWash,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: OrlandoTheme.sageMist),
                      ),
                      child: Text(
                        code,
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: OrlandoTheme.sageDark),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...details.map((detail) => Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: _RichTextRow(text: detail),
          )),
        ],
      ),
    );
  }
}

class _RichTextRow extends StatelessWidget {
  final String text;
  const _RichTextRow({required this.text});

  @override
  Widget build(BuildContext context) {
    // Basic Markdown support for **bold**
    final parts = text.split('**');
    List<TextSpan> spans = [];
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text: parts[i],
        style: TextStyle(
          fontWeight: i % 2 == 1 ? FontWeight.bold : FontWeight.normal,
          color: OrlandoTheme.inkSoft,
          fontSize: 13,
        ),
      ));
    }

    return RichText(
      text: TextSpan(children: spans),
    );
  }
}
