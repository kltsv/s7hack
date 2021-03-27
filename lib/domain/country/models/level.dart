import 'package:freezed_annotation/freezed_annotation.dart';

import 'country.dart';

part 'level.freezed.dart';

part 'level.g.dart';

@freezed
abstract class Level with _$Level {
  const Level._();

  const factory Level(
    Country country,
  ) = _Level;

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);
}
