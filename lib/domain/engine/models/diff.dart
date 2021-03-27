import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_diff.dart';

part 'diff.freezed.dart';

part 'diff.g.dart';

@freezed
abstract class Diff with _$Diff {
  static const empty = Diff([]);

  const Diff._();

  const factory Diff(
    List<ItemDiff> diff,
  ) = _Diff;

  factory Diff.fromJson(Map<String, dynamic> json) => _$DiffFromJson(json);
}
