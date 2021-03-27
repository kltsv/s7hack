import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/engine.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/ui/components/home_button.dart';

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
    _engine = Engine(widget.level.initialState);
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
                  final state = snapshot.data;
                  if (state == null) {
                    return Container(child: Text('Unknown state'));
                  }
                  return Container(
                    child: Center(child: Text(state.stepCount.toString())),
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
