import 'package:flutter_test/flutter_test.dart';
import 'package:s7hack/domain/engine/matcher.dart';
import 'package:s7hack/domain/engine/models/index.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';

void main() {
  test("search simple 3 in a column match", () {
    final List<List<Item>> field = [
      [Item(0, ItemType.bag), Item(1, ItemType.auto), Item(2, ItemType.diamond)],
      [Item(3, ItemType.plane), Item(4, ItemType.auto), Item(5, ItemType.auto)],
      [Item(6, ItemType.shield), Item(7, ItemType.auto), Item(8, ItemType.bag)],
    ];
    final Set<Index> expected = { Index(0, 1), Index(1, 1), Index(2, 1), };
    expect(findMatches(field, ItemType.auto, Index(2, 1)), expected);
  });

  test("search simple 3 in a row match", () {
    final List<List<Item>> field = [
      [Item(0, ItemType.bag), Item(1, ItemType.auto), Item(2, ItemType.diamond)],
      [Item(3, ItemType.plane), Item(4, ItemType.diamond), Item(5, ItemType.auto)],
      [Item(6, ItemType.auto), Item(7, ItemType.auto), Item(8, ItemType.auto)],
    ];
    final Set<Index> expected = { Index(2, 0), Index(2, 1), Index(2, 2), };
    expect(findMatches(field, ItemType.auto, Index(2, 0)), expected);
  });
}
