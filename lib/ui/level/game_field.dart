import 'package:flutter/material.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';

class GameField extends StatelessWidget {
  final List<List<Item>> field;

  const GameField({
    Key? key,
    required this.field,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.count(
          crossAxisCount: field.length,
          children: _asArray.map((item) => GameItem(item: item)).toList(),
        )
      ],
    );
  }

  List<Item> get _asArray => field.expand((element) => element).toList();
}

class GameItem extends StatelessWidget {
  final Item item;

  const GameItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: item.type == ItemType.plane ? Colors.green : Colors.blue,
        ),
      ),
    );
  }
}
