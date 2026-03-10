import 'package:flutter/material.dart';

class ChecklistScreen extends StatelessWidget {
  const ChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const Text(
          'Checklist de Preparação',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildItem('Passaportes e Vistos', true),
        _buildItem('Seguro Viagem', true),
        _buildItem('Reserva do Carro', false),
        _buildItem('Ingressos Parques', false),
        _buildItem('Remédios e Higiene', false),
      ],
    );
  }

  Widget _buildItem(String label, bool done) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: CheckboxListTile(
        title: Text(label, style: TextStyle(
          decoration: done ? TextDecoration.lineThrough : null,
          color: done ? Colors.grey : null,
        )),
        value: done,
        onChanged: (v) {},
        activeColor: const Color(0xFF3F5E42),
      ),
    );
  }
}
