import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/engine/models/item.dart';

import 'diff.dart';

part 'game_state.freezed.dart';

part 'game_state.g.dart';

@freezed
abstract class GameState with _$GameState {
  static const empty = GameState(0, [], Diff.empty, 0);

  const GameState._();

  const factory GameState(
    int stepCount,
    List<List<Item>> field,
    Diff diff,
    int score,
  ) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}

extension GameStateX on GameState {
  bool get isCompleted => stepCount == 0;
}
