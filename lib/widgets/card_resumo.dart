import 'package:flutter/material.dart';

class CardResumo extends StatelessWidget {
  const CardResumo({
    super.key,
    required this.icone,
    required this.titulo,
    required this.descricao,
    required this.aoTocar,
  });

  final IconData icone;
  final String titulo;
  final String descricao;
  final VoidCallback aoTocar;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          icone,
          size: 30,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(titulo),
        subtitle: Text(descricao),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: aoTocar,
      ),
    );
  }
}