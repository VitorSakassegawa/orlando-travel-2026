import 'package:flutter/material.dart';
import '../components/glass_card.dart';
import '../orlando_theme.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        _buildSection(context, 'Documentação', [
          'Passaporte e Vistos',
          'Seguro Viagem Impresso',
          'Reservas de Hotel e Carro',
        ]),
        const SizedBox(height: 24),
        _buildSection(context, 'Financeiro', [
          'Cartão Nomad/Wise Carregado',
          'Dólares em Espécie',
          'Avisar Bancos sobre Viagem',
        ]),
        const SizedBox(height: 24),
        _buildSection(context, 'Saúde & Malas', [
          'Remédios de Uso Contínuo',
          'Adaptadores de Tomada',
          'Tags de Mala e Cadeados',
        ]),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildSection(BuildContext context, String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(title.toUpperCase(), 
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: OrlandoTheme.sageDark,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassCard(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: OrlandoTheme.sand, width: 2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(item, style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
