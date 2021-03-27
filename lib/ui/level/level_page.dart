import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/engine.dart';
import 'package:s7hack/domain/engine/models/diff.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';
import 'package:s7hack/ui/components/home_button.dart';
import 'package:s7hack/ui/level/game_field.dart';

class LevelPage extends StatefulWidget {
  final Level level;

  LevelPage({Key? key, required this.level}) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  late final Engine _engine;

  @override
  void initState() {
    super.initState();
    _engine = Engine(widget.level.config);
    di.engineHolder.engine = _engine;
  }

  @override
  void dispose() {
    di.engineHolder.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: HomeButton(),
              pinned: true,
              title: Text(widget.level.name),
              centerTitle: true,
            ),
            SliverFillRemaining(
              child: StreamBuilder<GameState>(
                initialData: _engine.state,
                stream: _engine.changes,
                builder: (context, snapshot) {
                  final state = _mockedLevelState;
                  /*if (state == null) {
                    return Container(child: Text('Unknown state'));
                  }*/
                  return GameField(field: state.field);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const _mockedLevelState = GameState(
  0,
  [
    [
      Item(0, ItemType.bag),
      Item(1, ItemType.plane),
      Item(2, ItemType.bag),
      Item(3, ItemType.bag)
    ],
    [
      Item(4, ItemType.plane),
      Item(5, ItemType.bag),
      Item(6, ItemType.bag),
      Item(7, ItemType.plane)
    ],
    [
      Item(8, ItemType.bag),
      Item(9, ItemType.plane),
      Item(10, ItemType.plane),
      Item(11, ItemType.plane)
    ],
    [
      Item(12, ItemType.bag),
      Item(13, ItemType.plane),
      Item(14, ItemType.bag),
      Item(15, ItemType.plane)
    ],
  ],
  Diff.empty,
);
