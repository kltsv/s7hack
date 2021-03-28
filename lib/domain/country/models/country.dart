import 'package:freezed_annotation/freezed_annotation.dart';

import 'level.dart';

part 'country.freezed.dart';

part 'country.g.dart';

@freezed
abstract class Country with _$Country {
  const Country._();

  const factory Country(
    String id,
    String name,
    String imageAsset,
    String backgroundAsset,
    List<Level> levels,
    int score,
  ) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

extension CountryX on Country {
  double get progress =>
      ((score / levels.last.scoreToOpen) * 100).round().floorToDouble();

  bool get isCompleted => currentLevel.name == levels.last.name;

  Level get currentLevel =>
      levels.lastWhere((element) => element.status == LevelStatus.available);
}
