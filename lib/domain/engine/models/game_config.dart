import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_config.freezed.dart';

part 'game_config.g.dart';

@freezed
abstract class GameConfig with _$GameConfig {
  static const empty = GameConfig(0, 0, 0);

  const GameConfig._();

  const factory GameConfig(
    int rows,
    int columns,
    int steps,
  ) = _GameConfig;

  factory GameConfig.fromJson(Map<String, dynamic> json) =>
      _$GameConfigFromJson(json);
}
