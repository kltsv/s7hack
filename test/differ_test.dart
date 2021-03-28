import 'package:flutter_test/flutter_test.dart';
import 'package:s7hack/domain/engine/differ.dart';
import 'package:s7hack/domain/engine/models/index.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_diff.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';

void main() {
  test("simple 3 match in 2nd column", () {
    final List<List<Item>> field = [
      [
        Item(0, ItemType.bag),
        Item(1, ItemType.auto),
        Item(2, ItemType.diamond)
      ],
      [Item(3, ItemType.plane), Item(4, ItemType.auto), Item(5, ItemType.auto)],
      [Item(6, ItemType.shield), Item(7, ItemType.auto), Item(8, ItemType.bag)],
    ];
    final Set<ItemDiff> expected = {
      ItemDiff.explosion(Index(0, 1)),
      ItemDiff.explosion(Index(1, 1)),
      ItemDiff.explosion(Index(2, 1)),
    };

    expect(calcCollapsingDiff(field), expected);
  });

  test("no matches in 5x5 field", () {
    final List<List<Item>> field = [
      [
        Item(0, ItemType.bag),
        Item(1, ItemType.plane),
        Item(2, ItemType.shield),
        Item(3, ItemType.shield),
        Item(4, ItemType.plane),
      ],
      [
        Item(10, ItemType.auto),
        Item(11, ItemType.shield),
        Item(12, ItemType.diamond),
        Item(13, ItemType.plane),
        Item(14, ItemType.diamond),
      ],
      [
        Item(20, ItemType.bag),
        Item(21, ItemType.plane),
        Item(22, ItemType.shield),
        Item(23, ItemType.bag),
        Item(24, ItemType.diamond),
      ],
      [
        Item(30, ItemType.shield),
        Item(31, ItemType.bag),
        Item(32, ItemType.plane),
        Item(33, ItemType.auto),
        Item(34, ItemType.auto),
      ],
      [
        Item(40, ItemType.auto),
        Item(41, ItemType.diamond),
        Item(42, ItemType.bag),
        Item(43, ItemType.shield),
        Item(44, ItemType.plane),
      ],
    ];
    final Set<ItemDiff> expected = {};

    expect(calcCollapsingDiff(field), expected);
  });

  test("5 items matches in 5x5 field", () {
    final List<List<Item>> field = [
      [
        Item(0, ItemType.bag),
        Item(1, ItemType.plane),
        Item(2, ItemType.shield),
        Item(3, ItemType.shield),
        Item(4, ItemType.plane),
      ],
      [
        Item(10, ItemType.auto),
        Item(11, ItemType.shield),
        Item(12, ItemType.diamond),
        Item(13, ItemType.plane),
        Item(14, ItemType.diamond),
      ],
      [
        Item(20, ItemType.bag),
        Item(21, ItemType.plane),
        Item(22, ItemType.shield),
        Item(23, ItemType.shield),
        Item(24, ItemType.shield),
      ],
      [
        Item(30, ItemType.shield),
        Item(31, ItemType.bag),
        Item(32, ItemType.shield),
        Item(33, ItemType.auto),
        Item(34, ItemType.auto),
      ],
      [
        Item(40, ItemType.auto),
        Item(41, ItemType.diamond),
        Item(42, ItemType.shield),
        Item(43, ItemType.shield),
        Item(44, ItemType.plane),
      ],
    ];
    final Set<ItemDiff> expected = {
      ItemDiff.explosion(Index(2, 2)),
      ItemDiff.explosion(Index(2, 3)),
      ItemDiff.explosion(Index(2, 4)),
      ItemDiff.explosion(Index(3, 2)),
      ItemDiff.explosion(Index(4, 2)),
    };

    expect(calcCollapsingDiff(field), expected);
  });

  test("calc change diff horizontal", () {
    final List<List<Item?>> field = [
      [Item(0, ItemType.bag), Item(1, ItemType.bag), Item(2, ItemType.diamond)],
      [null, null, null],
      [
        Item(6, ItemType.shield),
        Item(7, ItemType.shield),
        Item(8, ItemType.bag)
      ],
    ];
    final expected = [
      // ItemDiffChange(Index(0, 0), Index(1, 0)),
      // ItemDiffChange(Index(0, 1), Index(1, 1)),
      // ItemDiffChange(Index(0, 2), Index(1, 2)),
    ];

    expect(calcChangeDiff(field), expected);
  });

  test("calc change diff vertical", () {
    final field = [
      [Item(0, ItemType.bag), Item(1, ItemType.bag), Item(2, ItemType.diamond)],
      [Item(3, ItemType.bag), Item(4, ItemType.bag), null],
      [Item(6, ItemType.shield), Item(7, ItemType.shield), null],
    ];
    final expected = [
      //ItemDiffChange(Index(0, 2), Index(2, 2)),
    ];

    expect(calcChangeDiff(field), expected);
  });
}
