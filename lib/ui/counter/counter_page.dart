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

  final _explodeController = <int, AnimationController>{};
  final _explodeAnimation = <int, Animation<double>>{};

  final _array = <int?>[];

  @override
  void initState() {
    super.initState();
    _array.addAll(widget.array);
    for (var i = 0; i < widget.array.length; i++) {
      _initAnim(i);
      _initExplosion(i);
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
                for (var i = 0; i < _array.length; i++) _buildItem(i, itemSize),
              ],
            )
          ],
        );
      },
    );
  }

  Widget _buildItem(int i, double itemSize) {
    final value = _array[i];
    Widget widget = ValueView(value: value, size: itemSize);
    widget = value != null && _explodeAnimation[value] != null
        ? ScaleTransition(scale: _explodeAnimation[value]!, child: widget)
        : widget;
    widget = value != null && _animation[value] != null
        ? SlideTransition(
            position: _animation[value]!,
            child: widget,
          )
        : widget;
    return GestureDetector(
      onTap: () => _explode([i]),
      child: FlingDetector(
        onRightFling: () => _swap(i, AxisDirection.right),
        onLeftFling: () => _swap(i, AxisDirection.left),
        onUpFling: () => _swap(i, AxisDirection.up),
        onDownFling: () => _swap(i, AxisDirection.down),
        child: widget,
      ),
    );
  }

  void _initAnim(int index) {
    final value = _array[index];
    if (value == null) {
      return;
    }
    final animController =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    final tween = Tween(begin: Offset.zero, end: Offset.zero);
    final animation = tween.animate(animController);
    _animController[value] = animController;
    _animation[value] = animation;
    _tween[value] = tween;
  }

  void _initExplosion(int index) {
    final value = _array[index];
    if (value == null) {
      return;
    }
    final animController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    final tween = Tween(begin: 1.0, end: 0.0);
    final curved = CurveTween(curve: Curves.easeOutBack);
    final animation = curved.animate(tween.animate(animController));
    _explodeController[value] = animController;
    _explodeAnimation[value] = animation;
  }

  Future<void> _swap(int index, AxisDirection direction) async {
    int toIndex;
    switch (direction) {
      case AxisDirection.up:
        toIndex = index - widget.columns;
        break;
      case AxisDirection.right:
        toIndex = index + 1;
        break;
      case AxisDirection.down:
        toIndex = index + widget.columns;
        break;
      case AxisDirection.left:
        toIndex = index - 1;
        break;
    }
    await Future.wait([
      _move(index, toIndex),
      _move(toIndex, index),
    ]);
    _swapState(index, toIndex);
  }

  void _swapState(int a, int b) {
    final tmp = _array[a];
    _array[a] = _array[b];
    _array[b] = tmp;
    setState(() {});
    print('Swapped: $a, $b');
    print(_array);
  }

  Future<void> _move(int from, int to) async {
    final fromValue = _array[from];
    if (fromValue == null) {
      return;
    }
    _tween[fromValue]?.end = _buildOffset(from, to);

    await _animController[fromValue]!.forward();
    _initAnim(from);
  }

  Offset _buildOffset(int from, int to) {
    if (from % widget.columns == to % widget.columns) {
      // на одной вертикальной оси
      final offset = (to ~/ widget.rows) - (from ~/ widget.rows);
      return Offset(0, offset.toDouble());
    } else if (from ~/ widget.rows == to ~/ widget.rows) {
      // на одной горизонтальной оси
      final offset = (to % widget.columns) - (from % widget.columns);
      return Offset(offset.toDouble(), 0);
    }
    throw Exception('No valid from/to: $from/$to');
  }

  Future<void> _explode(List<int> indexes) async {
    final futures = <Future>[];
    for (final i in indexes) {
      futures.add(_explodeAt(i));
    }
    await Future.wait(futures);
    _clearValue(indexes);
    print('Exploded: $indexes');
  }

  Future<void> _explodeAt(int index) async {
    final value = _array[index];
    if (value == null) {
      return;
    }

    await _explodeController[value]!.forward();
  }

  void _clearValue(List<int> indexes) {
    for (final i in indexes) {
      final value = _array[i];
      if (value == null) {
        continue;
      }
      _array[i] = null;
      _animController.remove(value);
      _tween.remove(value);
      _animation.remove(value);
      _explodeAnimation.remove(value);
    }
    setState(() {});
  }
}

class ValueView extends StatelessWidget {
  final int? value;
  final double size;

  const ValueView({
    Key? key,
    this.value,
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
          color: value != null ? Colors.green : null,
          child: Center(
            child: Text(
              value?.toString() ?? '',
            ),
          ),
        ),
      ),
    );
  }
}
