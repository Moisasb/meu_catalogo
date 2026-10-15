import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.telaAtual,
    required this.aoSelecionar,
  });

  final String telaAtual;
  final void Function(String) aoSelecionar;

  @override
  Widget build(BuildContext context) {
    final itens = [
      ('Início', Icons.home_outlined, 'inicio'),
      ('Meu perfil', Icons.person_outline, 'perfil'),
      ('Interesses', Icons.favorite_outline, 'interesses'),
      ('Configurações', Icons.settings_outlined, 'configuracoes'),
    ];

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.account_circle,
                  size: 54,
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimaryContainer,
                ),
                const SizedBox(height: 8),
                Text(
                  'Meu Catálogo',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Text('Seu espaço pessoal'),
              ],
            ),
          ),
          ...itens.map((item) {
            return ListTile(
              leading: Icon(item.$2),
              title: Text(item.$1),
              selected: telaAtual == item.$3,
              onTap: () {
                Navigator.pop(context);
                aoSelecionar(item.$3);
              },
            );
          }),
        ],
      ),
    );
  }
}