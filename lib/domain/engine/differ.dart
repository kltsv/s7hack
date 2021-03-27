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

List<List<Item?>> removeCollapsed(
  List<List<Item>> field,
  Set<ItemDiffExplosion> collapsingDiff,
) {
  final List<List<Item?>> newField =
      field.map((r) => r.map((c) => c as Item?).toList()).toList();
  collapsingDiff.forEach((element) {
    newField[element.index.i][element.index.j] = null;
  });
  return newField;
}

List<ItemDiffChange> calcChangeDiff(
  List<List<Item?>> collapsedField,
  Set<ItemDiffExplosion> collapsingDiff,
) {
  final diff = <ItemDiffChange>[];
  final Set<int> affectedColumns = collapsingDiff.map((e) => e.index.j).toSet();
  final int rows = collapsedField.length;
  final int columns = rows > 0 ? (collapsedField.getSafe(0)?.length ?? 0) : 0;

  for (var i = 0; i < rows; i++) {
    for (var j = 0; j < columns; j++) {

    }
  }

  collapsingDiff.forEach((element) {});

  return [];
}
