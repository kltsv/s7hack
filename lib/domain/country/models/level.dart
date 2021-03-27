import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/engine/models/game_config.dart';

part 'level.freezed.dart';

part 'level.g.dart';

@freezed
abstract class Level with _$Level {
  const Level._();

  const factory Level(
    String name,
    GameConfig config,
    LevelStatus status,
  ) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}

enum LevelStatus {
  unavailable,
  available,
  completed,
}
