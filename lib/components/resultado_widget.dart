import 'package:flutter/material.dart';

class ResultadoWidget extends StatelessWidget implements PreferredSizeWidget {
  final bool? venceu;
  final Function()? onReiniciar;

  const ResultadoWidget({
    super.key,
    this.venceu,
    this.onReiniciar,
  });

  Color _getCor() {
    if (venceu == null) {
      return Colors.yellow; // Amarelo para jogo em andamento
    } else if (venceu!) {
      return Colors.green[300]!; // Verde para vitória
    } else {
      return Colors.red[300]!; // Vermelho para derrota
    }
  }

  IconData _getIcon() {
    if (venceu == null) {
      return Icons
          .sentiment_satisfied; // Ícone de sorriso para jogo em andamento
    } else if (venceu!) {
      return Icons
          .sentiment_very_satisfied; // Ícone de sorriso feliz para vitória
    } else {
      return Icons
          .sentiment_very_dissatisfied; // Ícone de cara triste para derrota
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: _getCor(),
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: onReiniciar,
              icon: Icon(
                _getIcon(),
                color: Colors.black,
                size: 35,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}
