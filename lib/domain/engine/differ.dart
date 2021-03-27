import 'package:s7hack/utils/extensions.dart';

import 'matcher.dart';
import 'models/index.dart';
import 'models/item.dart';
import 'models/item_diff.dart';
import 'models/item_type.dart';

Set<ItemDiff> calcCollapsingDiff(List<List<Item>> field) {
  final Set<ItemDiff> diffs = {};
  final int rows = field.length;
  final int columns = rows > 0 ? (field.getSafe(0)?.length ?? 0) : 0;

  for (var i = 0; i < rows; i++) {
    final List<Item> row = field[i];
    for (var j = 0; j < columns; j++) {
      final Item item = row[j];
      final ItemType type = item.type;
      final Index index = Index(i, j);
      final Set<Index> matches = findMatches(field, type, index);
      diffs.addAll(matches.map((e) => ItemDiff.explosion(e)));
    }
  }

  return diffs;
}
