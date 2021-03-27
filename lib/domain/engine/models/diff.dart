import 'package:freezed_annotation/freezed_annotation.dart';

part 'diff.freezed.dart';

part 'diff.g.dart';

@freezed
abstract class Diff with _$Diff {
  static const empty = Diff(0);

  const Diff._();

  const factory Diff(
    int sth,
  ) = _Diff;

  factory Diff.fromJson(Map<String, dynamic> json) => _$DiffFromJson(json);
}
