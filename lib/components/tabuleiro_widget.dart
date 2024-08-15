import 'package:campo_minado/components/campo_widget.dart';
import 'package:campo_minado/models/celula.dart';
import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter/material.dart';

class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;
  final void Function(Celula) onAbrir;
  final void Function(Celula) onAlterarMarcacao;

  const TabuleiroWidget({
    super.key,
    required this.tabuleiro,
    required this.onAbrir,
    required this.onAlterarMarcacao,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: tabuleiro.colunas,
      children: tabuleiro.celulas.map(
        (c) {
          return CelulaWidget(
            celula: c,
            onAbrir: onAbrir,
            onAlterarMarcacao: onAlterarMarcacao,
          );
        },
      ).toList(),
    );
  }
}
