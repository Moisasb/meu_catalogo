
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/app_drawer.dart';
import 'interesses_screen.dart';
import 'configuracoes_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({
    super.key,
    required this.modoAtual,
    required this.aoAlterarTema,
  });

  final ThemeMode modoAtual;
  final void Function(ThemeMode) aoAlterarTema;

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nomeController = TextEditingController();
  final _sobrenomeController = TextEditingController();
  final _emailController = TextEditingController();

  final ImagePicker _seletorImagem = ImagePicker();

  File? _fotoPerfil;

  String nomeSalvo = '';
  String sobrenomeSalvo = '';
  String emailSalvo = '';

  @override
  void dispose() {
    _nomeController.dispose();
    _sobrenomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Abre a galeria para selecionar uma foto.
  Future<void> alterarFoto() async {
    try {
      final XFile? imagem = await _seletorImagem.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (imagem == null || !mounted) return;

      setState(() {
        _fotoPerfil = File(imagem.path);
      });
    } catch (erro, stackTrace) {
      debugPrint('Erro ao selecionar foto: $erro');
      debugPrint('$stackTrace');

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao selecionar foto: $erro'),
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  void salvarPerfil() {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      nomeSalvo = _nomeController.text.trim();
      sobrenomeSalvo = _sobrenomeController.text.trim();
      emailSalvo = _emailController.text.trim();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil salvo com sucesso!'),
      ),
    );
  }

  void navegar(String destino) {
    if (destino == 'perfil') return;

    if (destino == 'inicio') {
      Navigator.popUntil(context, (rota) => rota.isFirst);
      return;
    }

    final Widget tela;

    switch (destino) {
      case 'interesses':
        tela = InteressesScreen(
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
    final cores = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
      ),
      drawer: AppDrawer(
        telaAtual: 'perfil',
        aoSelecionar: navegar,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: cores.primaryContainer,
                  backgroundImage: _fotoPerfil != null
                      ? FileImage(_fotoPerfil!)
                      : null,
                  child: _fotoPerfil == null
                      ? Icon(
                          Icons.person,
                          size: 60,
                          color: cores.onPrimaryContainer,
                        )
                      : null,
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: alterarFoto,
                  icon: const Icon(Icons.photo_camera_outlined),
                  label: const Text('Alterar foto'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nomeController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Digite seu nome.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _sobrenomeController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Sobrenome',
                    prefixIcon: Icon(Icons.badge_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (valor) {
                    if (valor == null || valor.trim().isEmpty) {
                      return 'Digite seu sobrenome.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                  validator: (valor) {
                    if (valor == null ||
                        !RegExp(r'^[^@]+@[^@]+\.[^@]+$')
                            .hasMatch(valor.trim())) {
                      return 'Digite um e-mail válido.';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: salvarPerfil,
                    icon: const Icon(Icons.save_outlined),
                    label: const Text('Salvar perfil'),
                  ),
                ),
              ],
            ),
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
                    'Resumo do perfil',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Nome: ${nomeSalvo.isEmpty ? "Não informado" : nomeSalvo}',
                    style: TextStyle(color: cores.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sobrenome: ${sobrenomeSalvo.isEmpty ? "Não informado" : sobrenomeSalvo}',
                    style: TextStyle(color: cores.onSurface),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'E-mail: ${emailSalvo.isEmpty ? "Não informado" : emailSalvo}',
                    style: TextStyle(color: cores.onSurface),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
