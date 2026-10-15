import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import 'perfil_screen.dart';
import 'configuracoes_screen.dart';

class InteressesScreen extends StatefulWidget {
  const InteressesScreen({
    super.key,
    required this.modoAtual,
    required this.aoAlterarTema,
  });

  final ThemeMode modoAtual;
  final void Function(ThemeMode) aoAlterarTema;

  @override
  State<InteressesScreen> createState() => _InteressesScreenState();
}

class _InteressesScreenState extends State<InteressesScreen> {
  final List<String> interesses = [
    'Tecnologia',
    'Programação',
    'Jogos',
    'Música',
    'Filmes',
    'Esportes',
    'Leitura',
    'Design',
  ];

  final Set<String> selecionados = {};

  void navegar(String destino) {
    if (destino == 'interesses') return;

    if (destino == 'inicio') {
      Navigator.popUntil(context, (rota) => rota.isFirst);
      return;
    }

    final Widget tela;

    switch (destino) {
      case 'perfil':
        tela = PerfilScreen(
          modoAtual: widget.modoAtual,
          aoAlterarTema: widget.aoAlterarTema,
        );
        break;
      case 'configuracoes':
        tela = ConfiguracoesScreen(
          modoAtual: widget.modoAtual,
          aoAlterarTema: widget.aoAlterarTema,
        );
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => tela),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Interesses')),
      drawer: AppDrawer(
        telaAtual: 'interesses',
        aoSelecionar: navegar,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'O que você gosta?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text('Toque nos cartões para selecionar seus interesses.'),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: interesses.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (context, index) {
                  final interesse = interesses[index];
                  final selecionado = selecionados.contains(interesse);

                  return Card(
                    color: selecionado
                        ? Theme.of(context).colorScheme.primaryContainer
                        : null,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        setState(() {
                          if (selecionado) {
                            selecionados.remove(interesse);
                          } else {
                            selecionados.add(interesse);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              selecionado
                                  ? Icons.check_circle
                                  : Icons.favorite_outline,
                              size: 30,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              interesse,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text('Interesses selecionados: ${selecionados.length}'),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final mensagem = selecionados.isEmpty
                      ? 'Você ainda não selecionou interesses.'
                      : 'Você selecionou ${selecionados.length} interesse(s)!';

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(mensagem)),
                  );
                },
                child: const Text('Confirmar interesses'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}