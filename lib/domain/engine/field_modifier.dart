import 'models/item.dart';
import 'models/item_diff.dart';

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
