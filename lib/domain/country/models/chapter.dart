import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/country/models/country.dart';

import 'level.dart';

part 'chapter.freezed.dart';

part 'chapter.g.dart';

@freezed
abstract class Chapter with _$Chapter {
  const Chapter._();

  const factory Chapter(
    Country country,
    List<Level> levels,
  ) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);
}
