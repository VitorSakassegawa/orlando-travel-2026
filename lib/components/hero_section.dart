import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../orlando_theme.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 480,
      decoration: const BoxDecoration(
        color: OrlandoTheme.ink,
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1605723517503-3cadb5818a0c?q=80&w=1400&auto=format&fit=crop',
          ),
          fit: BoxFit.cover,
          opacity: 0.5,
        ),
      ),
      child: Stack(
        children: [
          // Gradient Overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  OrlandoTheme.ink.withOpacity(0.15),
                  OrlandoTheme.ink.withOpacity(0.4),
                  OrlandoTheme.ink.withOpacity(0.94),
                ],
                stops: const [0.0, 0.35, 1.0],
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 52.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Flag & Label
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.network(
                          'https://upload.wikimedia.org/wikipedia/en/a/a4/Flag_of_the_United_States.svg',
                          width: 22,
                          height: 15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TRAVEL PLANNER',
                        style: textTheme.labelMedium?.copyWith(
                          color: OrlandoTheme.sageLight,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                // Title
                RichText(
                  text: TextSpan(
                    style: textTheme.displayLarge?.copyWith(fontSize: 64, height: 0.92, letterSpacing: -2),
                    children: [
                      const TextSpan(text: 'Orlando\n'),
                      TextSpan(
                        text: '2026',
                        style: GoogleFonts.playfairDisplay(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          color: OrlandoTheme.sageLight,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  'Guia completo da viagem para Orlando 2026',
                  style: textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.55),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 22),
                // Chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _HeroChip(label: 'Viagem em ', value: '14/04/2026'),
                    _HeroChip(label: 'Dias restantes: ', value: '399'),
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

class _HeroChip extends StatelessWidget {
  final String label;
  final String value;

  const _HeroChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      decoration: BoxDecoration(
        color: OrlandoTheme.sage.withOpacity(0.15),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: OrlandoTheme.sage.withOpacity(0.3)),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 12, color: Colors.white70),
          children: [
            TextSpan(text: label),
            TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
