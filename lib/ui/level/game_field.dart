import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/engine/models/index.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';
import 'package:s7hack/ui/components/fling_detector.dart';

class GameField extends StatelessWidget {
  final List<List<Item>> field;

  const GameField({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final array = _asArray;
    return CustomScrollView(
      slivers: [
        SliverGrid.count(
          crossAxisCount: field.length,
          children: [
            for (var i = 0; i < array.length; i++)
              GameItem(index: Index.from1D(i, array.length), item: array[i])
          ],
        )
      ],
    );
  }

  List<Item> get _asArray => field.expand((element) => element).toList();
}

class GameItem extends StatelessWidget {
  final Index index;
  final Item item;

  const GameItem({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlingDetector(
      onUpSwipe: () => di.engine.swipe(index, index.up),
      onDownSwipe: () => di.engine.swipe(index, index.down),
      onRightSwipe: () => di.engine.swipe(index, index.right),
      onLeftSwipe: () => di.engine.swipe(index, index.left),
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            color: item.type == ItemType.plane ? Colors.green : Colors.blue,
          ),
        ),
      ),
    );
  }
}
