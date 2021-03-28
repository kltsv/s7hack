import 'dart:async';

import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/engine.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/ui/components/board.dart';
import 'package:s7hack/ui/components/home_button.dart';

class LevelPage extends StatefulWidget {
  static Map<String, dynamic> args(Level level, {bool fromRoot = false}) => {
        'level': level,
        'fromRoot': fromRoot,
      };

  static Level parseLevel(Map<String, dynamic> map) => map['level'] as Level;

  static bool parseFromRoot(Map<String, dynamic> map) =>
      map['fromRoot'] as bool;

  final bool fromRoot;
  final Level level;

  LevelPage({
    Key? key,
    required this.level,
    this.fromRoot = false,
  }) : super(key: key);

  @override
  _LevelPageState createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  late final Engine _engine;

  late final StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _engine = Engine(widget.level.config);
    di.engineHolder.engine = _engine;
    _subscription = _engine.changes.listen((state) {
      if(state.isCompleted) {
        di.navigation.showDialog(state);
      }
    });
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
              automaticallyImplyLeading: !widget.fromRoot,
              actions: [HomeButton()],
              pinned: true,
              title: Text(widget.level.name),
              centerTitle: true,
            ),
            SliverFillRemaining(
              child: StreamBuilder<GameState>(
                initialData: _engine.state,
                stream: _engine.changes,
                builder: (context, snapshot) {
                  final state = snapshot.data;
                  if (state == null) {
                    return Container(child: Text('Unknown state'));
                  }
                  return Board(engine: di.engine);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
