import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/engine/models/index.dart';

import 'item.dart';

part 'item_diff.freezed.dart';
part 'item_diff.g.dart';

@freezed
abstract class ItemDiff with _$ItemDiff {
  const ItemDiff._();

  const factory ItemDiff.explosion(Index index) = ItemDiffExplosion;

  const factory ItemDiff.change(Index from, Index to, Item item) =
      ItemDiffChange;

  factory ItemDiff.fromJson(Map<String, dynamic> json) =>
      _$ItemDiffFromJson(json);
}
