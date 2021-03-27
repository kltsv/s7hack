import 'package:flutter/material.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';
import 'package:s7hack/ui/components/board.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Board(
              array: List.generate(16, (index) => Item(index, ItemType.plane)),
              rows: 4,
              columns: 4)),
    );
  }
}
