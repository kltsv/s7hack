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
    List<Level> levels,
  ) = _Country;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);
}
