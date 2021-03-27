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
        leftPlOne: field.getSafe(i)?.getSafe(j - 2),
        topPlOne: field.getSafe(i - 2)?.getSafe(j),
        indexer: indexer,
      ));
    }
    // TODO проверять, не появилось ли 3 в ряд после шаффла
    field.shuffle();
  }

  return field;
}

Item _getRandomItem(
    {Item? left,
    Item? top,
    Item? leftPlOne,
    Item? topPlOne,
    required ItemIndexer indexer}) {
  final Map<ItemType, int> nearby = {};
  ItemType.values.forEach((element) {
    nearby[element] = 0;
  });
  [left, top, leftPlOne, topPlOne].forEach((element) {
    if (element != null) {
      final int count = nearby[element.type] ?? 0;
      nearby[element.type] = count + 1;
    }
  });
  ItemType type = _getLessMetType(nearby);
  return Item(indexer.getAndIncrement(), type);
}

ItemType _getLessMetType(Map<ItemType, int> nearby) {
  final values = ItemType.values;
  if (nearby.isEmpty) {
    return values[Random().nextInt(values.length)];
  }

  final nearbyList = nearby.entries.toList();
  nearbyList.sort((i1, i2) => i1.value.compareTo(i2.value));
  final lessMetType = nearbyList.first;
  final lessMetTypes = nearbyList
      .where((element) => element.value <= lessMetType.value)
      .toList();
  lessMetTypes.shuffle();
  return lessMetTypes.first.key;
}
