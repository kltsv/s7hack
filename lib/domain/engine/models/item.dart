import 'package:freezed_annotation/freezed_annotation.dart';

import 'item_type.dart';

part 'item.freezed.dart';

part 'item.g.dart';

@freezed
abstract class Item with _$Item {
  const Item._();

  const factory Item(
    int id,
    ItemType type,
  ) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
