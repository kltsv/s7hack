import 'package:s7hack/utils/extensions.dart';

import 'models/index.dart';
import 'models/item.dart';
import 'models/item_type.dart';

const int _matchesMin = 3;

Set<Index> findMatches(
  List<List<Item>> field,
  ItemType type,
  Index index,
) {
  final List<Index> matches = [];

  _MatchDirection.values.forEach((element) {
    matches.addAll(_findMatchesInDirection(field, type, index, element));
  });

  return matches.toSet();
}

List<Index> _findMatchesInDirection(
  List<List<Item>> field,
  ItemType type,
  Index index,
  _MatchDirection direction,
) {
  final List<Index> matches = [];
  matches.add(index);
  Index pointer = _movePointerToDirection(index, direction);
  bool canContinueSearch = _canSearchToDirection(field, index, direction);

  while (canContinueSearch) {
    Item nextItem = field[pointer.i][pointer.j];
    if (nextItem.type == type) {
      matches.add(Index(pointer.i, pointer.j));
      pointer = _movePointerToDirection(pointer, direction);
      canContinueSearch = pointer.i >= 0 && pointer.j >= 0;
    } else {
      canContinueSearch = false;
    }
  }

  if (matches.length < _matchesMin) {
    matches.clear();
  }
  return matches;
}

Index _movePointerToDirection(Index pointer, _MatchDirection direction) {
  switch (direction) {
    case _MatchDirection.Left:
      return pointer.copyWith(i: pointer.i - 1);
    case _MatchDirection.Top:
      return pointer.copyWith(i: pointer.j + 1);
    case _MatchDirection.Right:
      return pointer.copyWith(i: pointer.i + 1);
    case _MatchDirection.Bottom:
      return pointer.copyWith(i: pointer.j - 1);
  }
}

bool _canSearchToDirection(
  List<List<Item>> field,
  Index from,
  _MatchDirection direction,
) {
  final int matchesMinIndex = _matchesMin - 1;
  switch (direction) {
    case _MatchDirection.Left:
      return from.i >= matchesMinIndex;
    case _MatchDirection.Top:
      return from.j >= matchesMinIndex;
    case _MatchDirection.Right:
      final int lastColumnIndex = field.length - 1;
      return lastColumnIndex - from.i >= matchesMinIndex;
    case _MatchDirection.Bottom:
      final int lastRowIndex = field.getSafe(0)?.length ?? 0;
      return lastRowIndex - from.j >= matchesMinIndex;
  }
}

enum _MatchDirection {
  Left,
  Top,
  Right,
  Bottom,
}
