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
      if (state.isCompleted) {
        di.navigation.showCompleteGame(state);
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    di.engineHolder.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: !widget.fromRoot,
              actions: [HomeButton()],
              pinned: true,
              backgroundColor: Colors.transparent,
              textTheme: Theme.of(context).textTheme.copyWith(
                    headline6: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black87),
                  ),
              title: Text(widget.level.name),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: StreamBuilder<GameState>(
                  initialData: di.engine.state,
                  stream: di.engine.changes,
                  builder: (context, snapshot) {
                    final data = snapshot.data;
                    if (data == null) {
                      return const SizedBox.shrink();
                    }
                    return ListTile(
                      leading: Text('Очков: ${data.score}'),
                      trailing: Text('Осталось ходов: ${data.stepCount}'),
                    );
                  }),
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
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Board(engine: di.engine),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
