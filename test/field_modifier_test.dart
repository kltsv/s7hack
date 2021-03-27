import 'package:flutter_test/flutter_test.dart';
import 'package:s7hack/domain/engine/field_modifier.dart';
import 'package:s7hack/domain/engine/models/index.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_diff.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';

void main() {
  test("test removing collapsed items", () {
    final List<List<Item>> field = [
      [
        Item(0, ItemType.bag),
        Item(1, ItemType.auto),
        Item(2, ItemType.diamond)
      ],
      [Item(3, ItemType.plane), Item(4, ItemType.auto), Item(5, ItemType.auto)],
      [Item(6, ItemType.shield), Item(7, ItemType.auto), Item(8, ItemType.bag)],
    ];
    final Set<ItemDiffExplosion> collapsingDiff = {
      ItemDiffExplosion(Index(0, 1)),
      ItemDiffExplosion(Index(1, 1)),
      ItemDiffExplosion(Index(2, 1)),
    };
    final List<List<Item?>> expected = [
      [Item(0, ItemType.bag), null, Item(2, ItemType.diamond)],
      [Item(3, ItemType.plane), null, Item(5, ItemType.auto)],
      [Item(6, ItemType.shield), null, Item(8, ItemType.bag)],
    ];

    expect(removeCollapsed(field, collapsingDiff), expected);
  });
}
