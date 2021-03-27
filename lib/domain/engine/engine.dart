import 'dart:async';

import 'package:s7hack/domain/engine/models/game_state.dart';

import 'models/index.dart';

class Engine {
  final _controller = StreamController<GameState>.broadcast();

  Stream<GameState> get changes => _controller.stream;

  GameState _state;

  Engine(this._state);

  GameState get state => _state;

  bool swipe(Index from, Index to) {
    _state = _state.copyWith(stepCount: _state.stepCount + 1);
    return false;
  }

  void _push() {
    _controller.add(_state);
  }

  Future<void> dispose() => _controller.close();
}
