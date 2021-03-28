import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';

class CompleteArgs {

  GameState gameState = GameState.empty;
  Level level = Level.empty;

  CompleteArgs(final GameState gameState, final Level level) {
    this.gameState = gameState;
    this.level = level;
  }
}
