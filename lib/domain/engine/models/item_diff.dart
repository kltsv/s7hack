import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/engine/models/index.dart';

part 'item_diff.freezed.dart';

part 'item_diff.g.dart';

@freezed
abstract class ItemDiff with _$ItemDiff {
  const ItemDiff._();

  const factory ItemDiff.explosion(Index item) = ItemDiffExplosion;

  const factory ItemDiff.change(Index from, Index to) = ItemDiffChange;

  factory ItemDiff.fromJson(Map<String, dynamic> json) =>
      _$ItemDiffFromJson(json);
}
