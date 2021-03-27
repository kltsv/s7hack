import 'dart:math';

import 'package:s7hack/domain/engine/indexer.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';
import 'package:s7hack/utils/extensions.dart';

import 'models/item_type.dart';

List<List<Item>> generateField(int rows, int columns, ItemIndexer indexer) {
  final List<List<Item>> field = [];

  for (var i = 0; i < rows; i++) {
    field.add([]);
    for (var j = 0; j < columns; j++) {
      field[i].add(_getRandomItem(
        left: field.getSafe(i)?.getSafe(j - 1),
        top: field.getSafe(i - 1)?.getSafe(j),
        right: field.getSafe(i)?.getSafe(j + 1),
        bottom: field.getSafe(i + 1)?.getSafe(j),
        indexer: indexer,
      ));
    }
  }

  return field;
}

Item _getRandomItem(
    {Item? left,
    Item? top,
    Item? right,
    Item? bottom,
    required ItemIndexer indexer}) {
  final values = ItemType.values;
  final Map<ItemType, int> nearby = {};
  [left, top, right, bottom].forEach((element) {
    if (element != null) {
      final int count = nearby[element.type] ?? 0;
      nearby[element.type] = count + 1;
    }
  });
  ItemType type = values.length < nearby.length
      ? _getLessMetType(nearby)
      : values[Random().nextInt(values.length)];
  return Item(indexer.getAndIncrement(), type);
}

ItemType _getLessMetType(Map<ItemType, int> nearby) {
  var nearbyList = nearby.entries.toList();
  nearbyList.sort((i1, i2) => i1.value.compareTo(i2.value));
  return nearbyList.first.key;
}
