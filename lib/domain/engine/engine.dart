import 'dart:async';

import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/domain/engine/models/item_diff.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';
import 'package:s7hack/utils/extensions.dart';

import 'matcher.dart';
import 'models/index.dart';
import 'models/item.dart';

/// TODO
/// генерация поля по размеру
///
/// проверка можно ли сматчить в методе свайп
///
/// заполнение поля на место схлопнувшихся айтемов
/// условия победы - выбить определенное количество айтемов
///
/// после каждого хода проверка, возможно ли на данном поле совершить еще один ход - если нет, решафлим поле
class Engine {
  Engine(this._state);

  final _controller = StreamController<GameState>.broadcast();

  Stream<GameState> get changes => _controller.stream;

  GameState _state;
  int _itemsIdsCounter = 0;

  GameState get state => _state;

  bool swipe(Index from, Index to) {
    final bool canSwipe =
        _state.stepCount > 0 && _performChange(from, to, _state.field);
    if (canSwipe) {
      _state = _state.copyWith(stepCount: _state.stepCount - 1);
    }
    return canSwipe;
  }

  void _push() {
    _controller.add(_state);
  }

  Future<void> dispose() => _controller.close();

  bool _performChange(Index from, Index to, List<List<Item>> field) {
    final Item fromItem = field[from.i][from.j];
    final Item toItem = field[to.i][to.j];

    if (fromItem.type == toItem.type) {
      return false;
    }

    final List<List<Item>> changedField = field;
    changedField[from.i][from.j] = toItem;
    changedField[to.i][to.j] = fromItem;

    final List<ItemDiff> collapsingDiff = _calcCollapsingDiff(changedField);
    if (collapsingDiff.isNotEmpty) {
      /// todo
    }

    return true; /// todo
  }

  List<ItemDiff> _calcCollapsingDiff(List<List<Item>> field) {
    final List<ItemDiff> diffs = [];
    final int columns = field.length;
    /// todo здесь хрень какая-то
    final int rows = columns > 0 ? (field.getSafe(0)?.length ?? 0) : 0;

    /// todo
    for (var i = 0; i < columns; i++) {
      final List<Item> column = field[i];
      for (var j = 0; j < rows; j++) {
        final Item item = column[j];
        final ItemType type = item.type;
        final Index index = Index(i, j);
        final Set<Index> matches = findMatches(field, type, index);
        /// todo
      }
    }

    return diffs;
  }
}
