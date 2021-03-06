import 'dart:async';
import 'dart:math';

import 'package:s7hack/domain/engine/datagen.dart';
import 'package:s7hack/domain/engine/indexer.dart';
import 'package:s7hack/domain/engine/models/diff.dart';
import 'package:s7hack/domain/engine/models/game_config.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/domain/engine/models/item_diff.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';

import 'differ.dart';
import 'field_modifier.dart';
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
  Engine(GameConfig config) {
    _state = _state.copyWith(
      field: generateField(config.rows, config.columns, _indexer),
      stepCount: config.steps,
    );
    _config = config;
  }

  GameConfig _config = GameConfig.empty;

  final _controller = StreamController<GameState>.broadcast();

  Stream<GameState> get changes => _controller.stream;

  GameState _state = GameState.empty;
  ItemIndexer _indexer = ItemIndexer();

  GameState get state => _state;

  bool swipe(Index from, Index to) {
    final bool canSwipe =
        _state.stepCount > 0 && _performChange(from, to, _state.field);
    if (canSwipe) {
      _state = _state.copyWith(stepCount: _state.stepCount - 1);
      _push();
    }
    return canSwipe;
  }

  void _push() {
    _controller.add(_state);
  }

  Future<void> dispose() => _controller.close();

  void sync() {
    final Set<ItemDiffExplosion> collapsingDiff =
        calcCollapsingDiff(state.field);
    if (collapsingDiff.isNotEmpty) {
      _state = _state.copyWith(score: _state.score + collapsingDiff.length);
      _process(state.field, collapsingDiff);
      _push();
    }
  }

  void refreshField() {
    final newField = generateField(_config.rows, _config.columns, _indexer);
    _state = _state.copyWith(field: newField, diff: Diff.empty);
    _push();
  }

  bool _performChange(Index from, Index to, List<List<Item>> field) {
    final Item fromItem = field[from.i][from.j];
    final Item toItem = field[to.i][to.j];

    if (fromItem.type == toItem.type) {
      return false;
    }

    final List<List<Item>> changedField = field;
    changedField[from.i][from.j] = toItem;
    changedField[to.i][to.j] = fromItem;

    final Set<ItemDiffExplosion> collapsingDiff =
        calcCollapsingDiff(changedField);

    if (collapsingDiff.isEmpty) {
      return false;
    }
    _state = _state.copyWith(score: _state.score + collapsingDiff.length);

    _process(changedField, collapsingDiff);
    return true;
  }

  void _process(List<List<Item>> field, Set<ItemDiffExplosion> collapsingDiff) {
    final List<ItemDiffChange> changeDiff = [];
    var collapsedField = <List<Item?>>[];

    collapsedField = removeCollapsed(field, collapsingDiff);

    final fieldUpdate = _state.field;

    for (var i = 0; i < collapsedField.length; i++) {
      for (var j = 0; j < collapsedField[i].length; j++) {
        if (collapsedField[i][j] == null) {
          fieldUpdate[i][j] = _generateRandomItem(_indexer);
        }
      }
    }

    final entry = newCalcChangeDiff(collapsedField);
    changeDiff.addAll(entry.key);

    final list = <ItemDiff>[];

    list.addAll(collapsingDiff);
    list.addAll(changeDiff);

    changeDiff.forEach((change) {
      fieldUpdate[change.to.i][change.to.j] = change.item;
    });

    entry.value.forEach((element) {
      fieldUpdate[element.i][element.j] = _generateRandomItem(_indexer);
    });

    final diff = Diff(list);
    if (diff.diff.isNotEmpty) {
      _state = _state.copyWith(
        diff: diff,
        field: fieldUpdate,
      );
    }
  }
}

Item _generateRandomItem(ItemIndexer indexer) => Item(indexer.getAndIncrement(),
    ItemType.values[Random().nextInt(ItemType.values.length)]);
