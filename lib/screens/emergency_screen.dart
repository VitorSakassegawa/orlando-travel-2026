import 'package:flutter/material.dart';
import '../orlando_theme.dart';
import '../components/glass_card.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final TextEditingController _amountController = TextEditingController(text: '1.00');
  double _rate = 5.25; // Default rate
  bool _includeTax = true;
  bool _includeIOF = true;

  double get _result {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double totalRate = _rate;
    if (_includeTax) totalRate *= 1.065; // 6.5% sales tax
    if (_includeIOF) totalRate *= 1.0438; // 4.38% IOF
    return amount * totalRate;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(text: 'EMERGÊNCIA E ÚTEIS'),
          const SizedBox(height: 8),
          Text('Contatos e Câmbio', style: textTheme.displayMedium?.copyWith(fontSize: 24)),
          const SizedBox(height: 20),
          
          // Currency Converter
          _buildConverter(),
          
          const SizedBox(height: 24),
          _SectionLabel(text: 'CONTATOS DE EMERGÊNCIA'),
          const SizedBox(height: 12),
          _EmergencyContact(
            name: 'Emergência Geral (EUA)',
            desc: 'Polícia, Bombeiros, Ambulância',
            num: '911',
            icon: Icons.emergency_rounded,
            color: Colors.red.shade100,
          ),
          _EmergencyContact(
            name: 'Consulado Brasileiro',
            desc: 'Orlando (Setor de Emergência)',
            num: '+1 305 801 6201',
            icon: Icons.flag_rounded,
            color: OrlandoTheme.sageWash,
          ),
        ],
      ),
    );
  }

  Widget _buildConverter() {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // FROM
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFF0EDE6),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('QUAL VALOR? (USD)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(height: 8),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => setState(() {}),
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, letterSpacing: -1),
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '0.00'),
                ),
              ],
            ),
          ),
          // TO
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: OrlandoTheme.sageDark,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('EM REAIS (BRL)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white54)),
                const SizedBox(height: 8),
                Text(
                  'R\$ ${_result.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1),
                ),
                const SizedBox(height: 12),
                _buildTaxToggle('Taxa de Venda (6.5%)', _includeTax, (v) => setState(() => _includeTax = v!)),
                _buildTaxToggle('IOF Cartão (4.38%)', _includeIOF, (v) => setState(() => _includeIOF = v!)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxToggle(String label, bool value, Function(bool?) onChanged) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.white30),
      child: CheckboxListTile(
        title: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        value: value,
        onChanged: onChanged,
        dense: true,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: OrlandoTheme.sageLight,
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

class _EmergencyContact extends StatelessWidget {
  final String name;
  final String desc;
  final String num;
  final IconData icon;
  final Color color;

  const _EmergencyContact({
    required this.name,
    required this.desc,
    required this.num,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      color: color,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: OrlandoTheme.ink),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(desc, style: const TextStyle(fontSize: 12, color: OrlandoTheme.muted)),
                const SizedBox(height: 4),
                Text(num, style: const TextStyle(fontWeight: FontWeight.w900, color: OrlandoTheme.terracotta, fontSize: 16)),
              ],
            ),
          ),
          const Icon(Icons.call_rounded, color: OrlandoTheme.terracotta),
        ],
      ),
    );
  }
}
