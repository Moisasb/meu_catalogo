import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MeuCatalogo());
}

class MeuCatalogo extends StatefulWidget {
  const MeuCatalogo({super.key});

  @override
  State<MeuCatalogo> createState() => _MeuCatalogoState();
}

class _MeuCatalogoState extends State<MeuCatalogo> {
  ThemeMode modoAtual = ThemeMode.system;

  void alterarTema(ThemeMode novoModo) {
    setState(() {
      modoAtual = novoModo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu Catálogo',
      themeMode: modoAtual,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 2, 119, 113),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 2, 119, 113),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: HomeScreen(
        modoAtual: modoAtual,
        aoAlterarTema: alterarTema,
      ),
    );
  }
}