import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:s7hack/domain/game/models/item_type.dart';

part 'item.freezed.dart';

part 'item.g.dart';

@freezed
abstract class Item with _$Item {
  const Item._();

  const factory Item(
    ItemType type,
  ) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
