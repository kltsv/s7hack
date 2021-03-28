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
  ) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}

extension CountryX on Country {
  bool get isCompleted => currentLevel == null;

  Level? get currentLevel => levels
      .firstWhereOrNull((element) => element.status == LevelStatus.available);
}
