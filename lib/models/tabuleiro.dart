import 'celula.dart';
import 'dart:math';

class Tabuleiro {
  final int linhas;
  final int colunas;
  final int qtdBombas;
  final List<Celula> _celulas = [];

  Tabuleiro({
    required this.linhas,
    required this.colunas,
    required this.qtdBombas,
  }) {
    _criarCampos();
    _relacionarVizinhos();
    _sortearMinas();
  }

  List<Celula> get celulas {
    return _celulas;
  }

  bool get resolvido {
    return _celulas.every((celula) => celula.resolvido);
  }

  void reiniciar() {
    for (var c in _celulas) {
      c.reiniciar();
    }
    _sortearMinas();
  }

  void revelarBombas() {
    for (var c in _celulas) {
      c.revelarBombas();
    }
  }

  void _criarCampos() {
    for (int l = 0; l < linhas; l++) {
      for (int c = 0; c < colunas; c++) {
        _celulas.add(Celula(linha: l, coluna: c));
      }
    }
  }

  void _relacionarVizinhos() {
    for (var c in _celulas) {
      for (var vizinho in _celulas) {
        c.addVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int sorteadas = 0;

    if (qtdBombas > linhas * colunas) {
      return;
    }

    while (sorteadas < qtdBombas) {
      int i = Random().nextInt(_celulas.length);

      if (!_celulas[i].minado) {
        sorteadas++;
        _celulas[i].minar();
      }
    }
  }
}
