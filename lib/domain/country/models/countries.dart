import 'package:freezed_annotation/freezed_annotation.dart';

import 'country.dart';

part 'countries.freezed.dart';

part 'countries.g.dart';

@freezed
abstract class Countries with _$Countries {
  static const empty = Countries({});

  const Countries._();

  const factory Countries(
    Map<String, Country> countries,
  ) = _Countries;

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);
}
