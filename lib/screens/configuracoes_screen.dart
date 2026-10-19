import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import 'perfil_screen.dart';
import 'interesses_screen.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({
    super.key,
    required this.modoAtual,
    required this.aoAlterarTema,
  });

  final ThemeMode modoAtual;
  final void Function(ThemeMode) aoAlterarTema;

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  // Modo exibido na tela. Ele precisa ficar neste State porque a tela recebe
  // modoAtual apenas uma vez; sem isso o botão selecionado não mudaria ao tocar.
  late ThemeMode _modo;

  @override
  void initState() {
    super.initState();

    // Lê o modo realmente em uso no MaterialApp. O valor recebido pelo
    // construtor pode estar desatualizado, caso o tema tenha sido alterado
    // depois que a tela anterior foi criada.
    _modo =
        context.findAncestorWidgetOfExactType<MaterialApp>()?.themeMode ??
        widget.modoAtual;
  }

  // Navegação do menu lateral: cada opção abre a tela correspondente.
  // Como já estamos em Configurações, essa opção não faz nada.
  void navegar(String destino) {
    if (destino == 'configuracoes') return;

    if (destino == 'inicio') {
      // Volta até a primeira rota da pilha, que é a Home.
      Navigator.popUntil(context, (rota) => rota.isFirst);
      return;
    }

    final Widget tela;

    switch (destino) {
      case 'perfil':
        tela = PerfilScreen(
          modoAtual: _modo,
          aoAlterarTema: widget.aoAlterarTema,
        );
        break;

      case 'interesses':
        tela = InteressesScreen(
          modoAtual: _modo,
          aoAlterarTema: widget.aoAlterarTema,
        );
        break;

      default:
        return;
    }

    // pushReplacement troca esta tela pela nova, evitando deixar uma tela de
    // Configurações antiga na pilha, com o modo selecionado desatualizado.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => tela));
  }

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Configurações')),

      // O menu lateral usa ListTile para cada opção, como nas outras telas.
      drawer: AppDrawer(
        telaAtual: 'configuracoes',
        aoSelecionar: navegar,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Aparência do aplicativo',
              style: TextStyle(fontSize: 22),
            ),

            const SizedBox(height: 8),

            const Text('Escolha como deseja visualizar o aplicativo.'),

            const SizedBox(height: 20),

            SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.system,
                  label: Text('Sistema'),
                  icon: Icon(Icons.settings_suggest),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.light,
                  label: Text('Claro'),
                  icon: Icon(Icons.light_mode),
                ),
                ButtonSegment<ThemeMode>(
                  value: ThemeMode.dark,
                  label: Text('Escuro'),
                  icon: Icon(Icons.dark_mode),
                ),
              ],
              selected: {_modo},

              // setState atualiza o botão selecionado e o texto desta tela;
              // o callback avisa o MaterialApp para trocar o tema.
              onSelectionChanged: (novosModos) {
                setState(() {
                  _modo = novosModos.first;
                });
                widget.aoAlterarTema(novosModos.first);
              },
            ),

            const SizedBox(height: 24),

            Card(
              color: cores.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prévia do tema',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Este cartão acompanha as cores do tema selecionado.',
                      style: TextStyle(color: cores.onSurface),
                    ),

                    const SizedBox(height: 16),

                    FilledButton(
                      onPressed: () {},
                      child: const Text('Botão de exemplo'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              color: cores.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Modo selecionado: ${_modo.name}',
                  style: TextStyle(
                    color: cores.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
