import 'package:s7hack/utils/extensions.dart';

import 'matcher.dart';
import 'models/index.dart';
import 'models/item.dart';
import 'models/item_diff.dart';
import 'models/item_type.dart';

Set<ItemDiffExplosion> calcCollapsingDiff(List<List<Item>> field) {
  final Set<ItemDiffExplosion> diffs = {};
  final int rows = field.length;
  final int columns = rows > 0 ? (field.getSafe(0)?.length ?? 0) : 0;

  for (var i = 0; i < rows; i++) {
    final List<Item> row = field[i];
    for (var j = 0; j < columns; j++) {
      final Item item = row[j];
      final ItemType type = item.type;
      final Index index = Index(i, j);
      final Set<Index> matches = findMatches(field, type, index);
      diffs.addAll(matches.map((e) => ItemDiffExplosion(e)));
    }
  }

  return diffs;
}

List<ItemDiffChange> calcChangeDiff(List<List<Item?>> collapsedField) {
  final diff = <ItemDiffChange>[];
  final int rows = collapsedField.length;
  final int columns = rows > 0 ? (collapsedField.getSafe(0)?.length ?? 0) : 0;

  for (var i = rows - 1; i > 0; i--) {
    for (var j = 0; j < columns; j++) {
      final item = collapsedField[i][j];
      if (item == null) {
        Item? upperItem;
        var k = i - 1;
        do {
          final upperItem = collapsedField[k][j];
          final from = Index(k, j);
          if (upperItem != null && !diff.any((e) => e.from == from)) {
            final to = Index(i, j);
            diff.add(ItemDiffChange(from, to));
          }
          k--;
        } while (upperItem == null && k >= 0);
      }
    }
  }

  return diff;
}
