import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Board(array: array, rows: 4, columns: 4)),
    );
  }
}

final array = List.generate(16, (index) => index);

class Board extends StatefulWidget {
  final List<int> array;
  final int rows;
  final int columns;

  const Board({
    Key? key,
    required this.array,
    required this.rows,
    required this.columns,
  }) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.smallest;
        final itemSize = size.width == size.shortestSide
            ? size.width / widget.columns
            : size.height / widget.rows;
        return CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverGrid.count(
              crossAxisCount: widget.columns,
              children: [
                for (var i = 0; i < array.length; i++)
                  ValueView(value: array[i], size: itemSize),
              ],
            )
          ],
        );
      },
    );
  }
}

class ValueView extends StatelessWidget {
  final int value;
  final double size;

  const ValueView({
    Key? key,
    required this.value,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: Colors.green,
          child: Center(
            child: Text(
              value.toString(),
            ),
          ),
        ),
      ),
    );
  }
}
