import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/engine/models/game_config.dart';

part 'level.freezed.dart';

part 'level.g.dart';

@freezed
abstract class Level with _$Level {
  const Level._();

  const factory Level(
    String name,
    String description,
    GameConfig config,
    int scoreToOpen,
    int scoreToDone,
    String bonusUrl,
  ) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}

extension LevelX on Level {
  LevelStatus status(int currentScore) => currentScore < scoreToOpen
      ? LevelStatus.unavailable
      : currentScore < scoreToDone
          ? LevelStatus.available
          : LevelStatus.completed;
}

enum LevelStatus {
  unavailable,
  available,
  completed,
}
