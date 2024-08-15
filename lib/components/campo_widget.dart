import 'package:campo_minado/models/celula.dart';
import 'package:flutter/material.dart';

class CelulaWidget extends StatelessWidget {
  final Celula celula;
  final void Function(Celula) onAbrir;
  final void Function(Celula) onAlterarMarcacao;

  const CelulaWidget({
    super.key,
    required this.celula,
    required this.onAbrir,
    required this.onAlterarMarcacao,
  });

  Widget _getImage() {
    int qtdeMinas = celula.qtdMinasVizinhaca;

    if (celula.aberto && celula.minado && celula.explodido) {
      return Image.asset('assets/images/bomba_0.jpeg');
    } else if (celula.aberto && celula.minado) {
      return Image.asset('assets/images/bomba_1.jpeg');
    } else if (celula.aberto) {
      return Image.asset('assets/images/aberto_$qtdeMinas.jpeg');
    } else if (celula.marcado) {
      return Image.asset('assets/images/bandeira.jpeg');
    } else {
      return Image.asset('assets/images/fechado.jpeg');
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onAbrir(celula),
      onLongPress: () => onAlterarMarcacao(celula),
      child: _getImage(),
    );
  }
}
