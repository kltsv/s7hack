import 'package:flutter/material.dart';
import 'package:s7hack/ui/components/fling_detector.dart';

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
              array: List.generate(16, (index) => index), rows: 4, columns: 4)),
    );
  }
}

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

class _BoardState extends State<Board> with TickerProviderStateMixin {
  final _animController = <int, AnimationController>{};
  final _animation = <int, Animation<Offset>>{};
  final _tween = <int, Tween<Offset>>{};

  final _array = <int>[];

  @override
  void initState() {
    super.initState();
    _array.addAll(widget.array);
    for (var i = 0; i < widget.array.length; i++) {
      initAnim(i);
    }
  }

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
                for (var i = 0; i < _array.length; i++)
                  FlingDetector(
                    onRightFling: () => moveRight(i),
                    onLeftFling: () => moveLeft(i),
                    onUpFling: () => moveUp(i),
                    onDownFling: () => moveDown(i),
                    child: SlideTransition(
                      position: _animation[_array[i]]!,
                      child: ValueView(value: _array[i], size: itemSize),
                    ),
                  ),
              ],
            )
          ],
        );
      },
    );
  }

  void initAnim(int index) {
    final value = _array[index];
    final animController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final tween = Tween(begin: Offset.zero, end: Offset(0, 1));
    final animation = tween.animate(animController);
    _animController[value] = animController;
    _animation[value] = animation;
    _tween[value] = tween;
  }

  Future<void> move(int index, AxisDirection direction) async {
    int toIndex;
    final from = _array[index];
    int to;
    switch (direction) {
      case AxisDirection.up:
        toIndex = index - widget.columns;
        to = _array[toIndex];
        _tween[from]?.end = Offset(0, -1);
        _tween[to]?.end = Offset(0, 1);
        break;
      case AxisDirection.right:
        toIndex = index + 1;
        to = _array[toIndex];
        _tween[from]?.end = Offset(1, 0);
        _tween[to]?.end = Offset(-1, 0);
        break;
      case AxisDirection.down:
        toIndex = index + widget.columns;
        to = _array[toIndex];
        _tween[from]?.end = Offset(0, 1);
        _tween[to]?.end = Offset(0, -1);
        break;
      case AxisDirection.left:
        toIndex = index - 1;
        to = _array[toIndex];
        _tween[from]?.end = Offset(-1, 0);
        _tween[to]?.end = Offset(1, 0);
        break;
    }
    await Future.wait([
      _animController[from]!.forward(),
      _animController[to]!.forward(),
    ]);

    initAnim(index);
    initAnim(toIndex);

    _swap(index, toIndex);
  }

  void _swap(int a, int b) {
    final tmp = _array[a];
    _array[a] = _array[b];
    _array[b] = tmp;
    setState(() {});
    print('Swapped: $a, $b');
    print(_array);
  }

  Future<void> moveLeft(int index) => move(index, AxisDirection.left);

  Future<void> moveRight(int index) => move(index, AxisDirection.right);

  Future<void> moveUp(int index) => move(index, AxisDirection.up);

  Future<void> moveDown(int index) => move(index, AxisDirection.down);
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
