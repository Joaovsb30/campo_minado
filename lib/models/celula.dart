import 'package:campo_minado/models/explosao_exception.dart';

class Celula {
  final int linha;
  final int coluna;
  final List<Celula> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Celula({
    required this.linha,
    required this.coluna,
  });

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get vizinhacaSegura {
    return vizinhos.every((v) => !v.minado);
  }

  int get qtdMinasVizinhaca {
    return vizinhos.where((v) => v.minado).length;
  }

  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool abertoEVazio = aberto && !minado;
    return minadoEMarcado || abertoEVazio;
  }

  void addVizinho(Celula vizinho) {
    final deltaLinha = (linha - vizinho.linha).abs();
    final deltaColuna = (coluna - vizinho.coluna).abs();

    if (deltaLinha == 0 && deltaColuna == 0) {
      return;
    }

    if (deltaLinha <= 1 && deltaColuna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (aberto) {
      return;
    }

    _aberto = true;

    if (minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhacaSegura) {
      for (var v in vizinhos) {
        v.abrir();
      }
    }
  }

  void revelarBombas() {
    if (minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alterarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _explodido = false;
    _minado = false;
    _marcado = false;
  }
}
