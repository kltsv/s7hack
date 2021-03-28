import 'dart:async';

import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/app/logger.dart';
import 'package:s7hack/domain/engine/engine.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/domain/engine/models/index.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_diff.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';
import 'package:s7hack/ui/components/fling_detector.dart';

class Board extends StatefulWidget {
  final Engine engine;

  const Board({
    Key? key,
    required this.engine,
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

  final _createController = <int, AnimationController>{};
  final _createAnimation = <int, Animation<double>>{};

  final _array = <Item?>[];
  late final int columns;
  late final int rows;

  late final Engine _engine;

  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _engine = widget.engine;
    _updateArray();
    columns = widget.engine.state.field[0].length;
    rows = widget.engine.state.field.length;

    for (var i = 0; i < _array.length; i++) {
      _initAnim(i);
      _initExplosion(i);
    }

    _initDiffUpdates();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _initDiffUpdates() {
    _subscription = _engine.changes.listen((state) async {
      final explosions = state.diff.diff.whereType<ItemDiffExplosion>();
      final changes = state.diff.diff.whereType<ItemDiffChange>();
      final creates =
          state.diff.diff.whereType<ItemDiffChange>().map((e) => e.from);

      await _explode(explosions.map((e) => e.index.as1D(columns)).toList());

      final futures = <Future>[];
      for (final change in changes) {
        final controller =
            _move(change.from.as1D(columns), change.to.as1D(columns));
        futures.add(controller.forward());
      }
      await Future.wait(futures);

      for (final change in changes) {
        _initAnim(change.from.as1D(columns));
      }
      setState(() {});

      final futureCreates = <Future>[];
      for (final create in creates) {
        _initCreate(create.as1D(columns));
        final controller = _createController[create];
        if (controller != null) {
          futureCreates.add(controller.forward());
        }
      }

      await Future.wait(futureCreates);

      setState(() {});
      _updateArray();

      for (final create in creates) {
        _clearCreate(create.as1D(columns));
      }

      setState(() {});

      Future.delayed(Duration(milliseconds: 700));

      if (!state.isCompleted) {
        di.engine.sync();
      }
    });
  }

  void _updateArray() {
    _array.clear();
    _array.addAll(_engine.state.field.expand((element) => element));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.smallest;
        final itemSize = size.width == size.shortestSide
            ? size.width / columns
            : size.height / rows;

        return CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverGrid.count(
              crossAxisCount: columns,
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
    Widget widget = ValueView(
      key: value != null ? ValueKey(value.id) : null,
      value: value,
      size: itemSize,
    );
    widget = _createAnimation[i] != null
        ? ScaleTransition(scale: _createAnimation[i]!, child: widget)
        : widget;
    widget = value != null && _explodeAnimation[i] != null
        ? ScaleTransition(scale: _explodeAnimation[i]!, child: widget)
        : widget;
    widget = value != null && _animation[i] != null
        ? SlideTransition(
            position: _animation[i]!,
            child: widget,
          )
        : widget;
    return FlingDetector(
      onRightFling: () => _swap(i, AxisDirection.right),
      onLeftFling: () => _swap(i, AxisDirection.left),
      onUpFling: () => _swap(i, AxisDirection.up),
      onDownFling: () => _swap(i, AxisDirection.down),
      child: widget,
    );
  }

  void _initAnim(int index) {
    final animController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    final tween = Tween(begin: Offset.zero, end: Offset.zero);
    final animation = tween.animate(animController);
    _animController[index] = animController;
    _animation[index] = animation;
    _tween[index] = tween;
  }

  void _initExplosion(int index) {
    final animController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this);
    final tween = Tween(begin: 1.0, end: 0.0);
    final curved = CurveTween(curve: Curves.easeOutBack);
    final animation = curved.animate(tween.animate(animController));
    _explodeController[index] = animController;
    _explodeAnimation[index] = animation;
  }

  void _initCreate(int index) {
    final animController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    final tween = Tween(begin: 0.0, end: 1.0);
    final curved = CurveTween(curve: Curves.ease);
    final animation = curved.animate(tween.animate(animController));
    _createController[index] = animController;
    _createAnimation[index] = animation;
  }

  void _clearCreate(int index) {
    _createController.remove(index);
    _createAnimation.remove(index);
  }

  Future<void> _swap(int index, AxisDirection direction) async {
    int toIndex;
    switch (direction) {
      case AxisDirection.up:
        toIndex = index - columns;
        break;
      case AxisDirection.right:
        toIndex = index + 1;
        break;
      case AxisDirection.down:
        toIndex = index + columns;
        break;
      case AxisDirection.left:
        toIndex = index - 1;
        break;
    }
    final outOfField = toIndex < 0 ||
        toIndex >= _array.length ||
        (!_isOnVertical(index, toIndex) && !_isOnHorizontal(index, toIndex));

    if (outOfField) {
      return;
    }

    final fromController = _move(index, toIndex);
    final toController = _move(toIndex, index);

    logger.info('Start swap: $index, $toIndex');

    await Future.wait([
      fromController.forward(),
      toController.forward(),
    ]);

    final isAllowed = _engine.swipe(
        Index.from1D(index, columns), Index.from1D(toIndex, columns));

    logger.info('Allowed to swap: $isAllowed');

    if (isAllowed) {
      _swapState(index, toIndex);
    } else {
      await Future.wait([
        toController.reverse(),
        fromController.reverse(),
      ]);
    }
    _initAnim(index);
    _initAnim(toIndex);

    setState(() {});
  }

  void _swapState(int a, int b) {
    final tmp = _array[a];
    _array[a] = _array[b];
    _array[b] = tmp;
    logger.info('Swapped: $a, $b');
  }

  AnimationController _move(int from, int to) {
    _tween[from]!.end = _buildOffset(from, to);
    return _animController[from]!;
  }

  Offset _buildOffset(int from, int to) {
    if (_isOnVertical(from, to)) {
      // на одной вертикальной оси
      final offset = (to ~/ columns) - (from ~/ columns);
      return Offset(0, offset.toDouble());
    } else if (_isOnHorizontal(from, to)) {
      // на одной горизонтальной оси
      final offset = (to % columns) - (from % columns);
      return Offset(offset.toDouble(), 0);
    }
    throw Exception(
        'No valid from/to: $from/$to (rows: ${rows}, columns: ${columns})');
  }

  bool _isOnVertical(int from, int to) => from % columns == to % columns;

  bool _isOnHorizontal(int from, int to) => from ~/ columns == to ~/ columns;

  Future<void> _explode(List<int> indexes) async {
    final futures = <Future>[];
    for (final i in indexes) {
      futures.add(_explodeAt(i));
    }
    await Future.wait(futures);
    for (final i in indexes) {
      _initExplosion(i);
    }
    _clearValue(indexes);
    logger.info('Exploded: $indexes');
  }

  Future<void> _explodeAt(int index) async {
    await _explodeController[index]!.forward();
  }

  void _clearValue(List<int> indexes) {
    for (final i in indexes) {
      final value = _array[i];
      if (value == null) {
        continue;
      }
      _array[i] = null;
    }
  }
}

class ValueView extends StatelessWidget {
  final Item? value;
  final double size;

  const ValueView({
    Key? key,
    this.value,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final v = value;
    return Container(
      width: size,
      height: size,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          child: v != null ? Image.asset(v.type.asset) : null,
        ),
      ),
    );
  }
}
