import 'package:flutter/material.dart';

import '../widgets/app_drawer.dart';
import 'perfil_screen.dart';
import 'interesses_screen.dart';
import 'configuracoes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.modoAtual,
    required this.aoAlterarTema,
  });

  final ThemeMode modoAtual;
  final void Function(ThemeMode) aoAlterarTema;

  void navegar(BuildContext context, String destino) {
    if (destino == 'inicio') {
      Navigator.popUntil(context, (rota) => rota.isFirst);
      return;
    }

    if (destino == 'perfil') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              PerfilScreen(modoAtual: modoAtual, aoAlterarTema: aoAlterarTema),
        ),
      );
      return;
    }

    final Widget? tela;

    switch (destino) {
      case 'interesses':
        tela = InteressesScreen(
          modoAtual: modoAtual,
          aoAlterarTema: aoAlterarTema,
        );
        break;

      case 'configuracoes':
        tela = ConfiguracoesScreen(
          modoAtual: modoAtual,
          aoAlterarTema: aoAlterarTema,
        );
        break;

      default:
        return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => tela!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Catálogo'), centerTitle: true),
      drawer: AppDrawer(
        telaAtual: 'inicio',
        aoSelecionar: (destino) => navegar(context, destino),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Descubra o que assistir',
              style: Theme.of(context).textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Sugestões de filmes, séries, animes e novelas.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),

          const CarrosselCategoria(
            titulo: 'Filmes',
            icone: Icons.movie_outlined,
            itens: [
              ItemEntretenimento(
                titulo: 'Interestelar',
                descricao: 'Ficção científica',
                imagem: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
              ),
              ItemEntretenimento(
                titulo: 'A Origem',
                descricao: 'Suspense e ação',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/9e3Dz7aCANy5aRUQF745IlNloJ1.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Duna',
                descricao: 'Aventura e ficção',
                imagem: 'https://image.tmdb.org/t/p/w500/d5NXSklXo0qyIYkgV94XAgMIckC.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Harry Potter e a Pedra Filosofal',
                descricao: 'Aventura e Fantasia',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/4rtsbE9aQ1qw4gv7yYwaNYfWFoS.jpg',
              ),
            ],
          ),

          const SizedBox(height: 24),

          const CarrosselCategoria(
            titulo: 'Séries',
            icone: Icons.live_tv_outlined,
            itens: [
              ItemEntretenimento(
                titulo: 'Stranger Things',
                descricao: 'Mistério e aventura',
                imagem: 'https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Wandinha',
                descricao: 'Fantasia e mistério',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/7rxiQrZjrer0RB9qNA8rHYFo53R.jpg',
              ),
              ItemEntretenimento(
                titulo: 'The Last of Us',
                descricao: 'Drama e aventura',
                imagem: 'https://image.tmdb.org/t/p/w500/dmo6TYuuJgaYinXBPjrgG9mB5od.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Ted Lasso',
                descricao: 'Drama e Comédia',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/uRHsiw1wLxPHFXkkv4Ix1s0O6f4.jpg',
              ),
            ],
          ),

          const SizedBox(height: 24),

          const CarrosselCategoria(
            titulo: 'Animes',
            icone: Icons.auto_awesome_outlined,
            itens: [
              ItemEntretenimento(
                titulo: 'Demon Slayer',
                descricao: 'Ação e fantasia',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/sECEixUi3ziwNukMTpkHPpaYWV1.jpg',
              ),
              ItemEntretenimento(
                titulo: 'One Piece',
                descricao: 'Aventura',
                imagem: 'https://image.tmdb.org/t/p/w500/cMD9Ygz11zjJzAovURpO75Qg7rT.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Naruto',
                descricao: 'Ação e aventura',
                imagem: 'https://image.tmdb.org/t/p/w500/vauCEnR7CiyBDzRCeElKkCaXIYu.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Black Clover',
                descricao: 'Ação, aventura e fantasia',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/kaMisKeOoTBPxPkbC3OW7Wgt6ON.jpg',
              ),
            ],
          ),

          const SizedBox(height: 24),

          const CarrosselCategoria(
            titulo: 'Novelas',
            icone: Icons.theaters_outlined,
            itens: [
              ItemEntretenimento(
                titulo: 'Avenida Brasil',
                descricao: 'Drama brasileiro',
                imagem: 'https://image.tmdb.org/t/p/original/4HPgLRimUxjMWld2mSTZe7zceXv.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Êta Mundo Bom!',
                descricao: 'Comédia e romance',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/gAbt0tV2Z0z2zSYEjDzhsyy74d7.jpg',
              ),
              ItemEntretenimento(
                titulo: 'Pantanal',
                descricao: 'Drama brasileiro',
                imagem: 'https://image.tmdb.org/t/p/w600_and_h900_face/aQEEVJLZwNsdBXcZrlecExYje2n.jpg',
              ),
               ItemEntretenimento(
                titulo: 'Cheias de Charme',
                descricao: 'Comédia brasileira',
                imagem: 'https://image.tmdb.org/t/p/w1280/3S4I5gWnrk6cV783mQto3orO12C.jpg',
              ),
            ],
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class ItemEntretenimento {
  final String titulo;
  final String descricao;
  final String imagem;

  const ItemEntretenimento({
    required this.titulo,
    required this.descricao,
    required this.imagem,
  });
}

class CarrosselCategoria extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final List<ItemEntretenimento> itens;

  const CarrosselCategoria({
    super.key,
    required this.titulo,
    required this.icone,
    required this.itens,
  });

  @override
  Widget build(BuildContext context) {
    final cores = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(icone, color: cores.primary),
              const SizedBox(width: 8),
              Text(
                titulo,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                '${itens.length} sugestões',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: itens.length,
            itemBuilder: (context, index) {
              final item = itens[index];

              return Container(
                width: 150,
                margin: const EdgeInsets.only(right: 12),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            item.imagem,
                            fit: BoxFit.cover,
                            errorBuilder: (context, erro, stackTrace) {
                              return Container(
                                color: cores.surfaceContainerHighest,
                                child: Center(
                                  child: Icon(
                                    icone,
                                    size: 48,
                                    color: cores.onSurfaceVariant,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 2),
                        child: Text(
                          item.titulo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 10),
                        child: Text(
                          item.descricao,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
