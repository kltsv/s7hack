import 'package:flutter/material.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';

class CompletePage extends StatelessWidget {
  final GameState state;

  const CompletePage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
      child: Material(
        color: Colors.transparent,
        child: Card(
          child: Container(
            child: Center(
              child: Text('Заработано очков: ${state.score}'),
            ),
          ),
        ),
      ),
    );
  }
}
