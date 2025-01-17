import 'package:campo_minado/components/resultado_widget.dart';
import 'package:campo_minado/components/tabuleiro_widget.dart';
import 'package:campo_minado/models/celula.dart';
import 'package:campo_minado/models/explosao_exception.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class CampoMinadoApp extends StatefulWidget {
  const CampoMinadoApp({super.key});

  @override
  State<CampoMinadoApp> createState() => _CampoMinadoAppState();
}

class _CampoMinadoAppState extends State<CampoMinadoApp> {
  bool? _venceu;
  Tabuleiro? _tabuleiro;

  void _reiniciar() {
    setState(() {
      _venceu = null;
      _tabuleiro!.reiniciar();
    });
  }

  void _alterarMarcacao(Celula celula) {
    if (_venceu != null) {
      return;
    }

    setState(() {
      celula.alterarMarcacao();
      if (_tabuleiro!.resolvido) {
        _venceu = true;
      }
    });
  }

  void _abrir(Celula celula) {
    setState(() {
      if (_venceu != null) {
        return;
      }

      setState(() {
        try {
          celula.abrir();
          if (_tabuleiro!.resolvido) {
            _venceu = true;
          }
        } on ExplosaoException {
          _venceu = false;
          _tabuleiro!.revelarBombas();
        }
      });
    });
  }

  Tabuleiro _getTabuleiro(double largura, double altura) {
    if (_tabuleiro == null) {
      int qtdeColunas = 15;
      double tamanhoCampo = largura / qtdeColunas;

      int qtdeLinhas = (altura / tamanhoCampo).floor();

      _tabuleiro = Tabuleiro(
        linhas: qtdeLinhas,
        colunas: qtdeColunas,
        qtdBombas: 50,
      );
    }
    return _tabuleiro!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: ResultadoWidget(
          venceu: _venceu,
          onReiniciar: _reiniciar,
        ),
        body: Container(
          color: Colors.grey,
          child: LayoutBuilder(builder: (ctx, contraints) {
            return TabuleiroWidget(
                tabuleiro: _getTabuleiro(
                  contraints.maxWidth,
                  contraints.maxHeight,
                ),
                onAbrir: _abrir,
                onAlterarMarcacao: _alterarMarcacao);
          }),
        ),
      ),
    );
  }
}
