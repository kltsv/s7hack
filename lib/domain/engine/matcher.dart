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

  MatchDirection.values.forEach((element) {
    matches.addAll(_findMatchesInDirection(field, type, index, element));
  });

  return matches.toSet();
}

List<Index> _findMatchesInDirection(
  List<List<Item>> field,
  ItemType type,
  Index pointer,
  MatchDirection direction,
) {
  final List<Index> matches = [];
  bool canContinueSearch =
      _canSearchToDirection(field, pointer, direction, _matchesMin - 1);
  print(
      "_findMatchesInDirection: start $direction $canContinueSearch $pointer $type");

  while (canContinueSearch) {
    final Item nextItem = field[pointer.i][pointer.j];
    if (nextItem.type == type) {
      print(
          "_findMatchesInDirection: got sovpadenie! $pointer ${matches.length}");
      matches.add(pointer);
      pointer = movePointerToDirection(pointer, direction);
      int matchesMinIndex = _matchesMin - matches.length - 1;
      if (matchesMinIndex < 0) {
        matchesMinIndex = 0;
      }
      canContinueSearch =
          _canSearchToDirection(field, pointer, direction, matchesMinIndex);
      print(
          "_findMatchesInDirection: got sovpadenie! canContinueSearch=$canContinueSearch matchesMinIndex=$matchesMinIndex");
    } else {
      canContinueSearch = false;
    }
  }
  print("_findMatchesInDirection: end $direction $matches");

  if (matches.length < _matchesMin) {
    matches.clear();
  }
  return matches;
}

Index movePointerToDirection(Index pointer, MatchDirection direction) {
  switch (direction) {
    case MatchDirection.Left:
      return pointer.copyWith(j: pointer.j - 1);
    case MatchDirection.Top:
      return pointer.copyWith(i: pointer.i - 1);
    case MatchDirection.Right:
      return pointer.copyWith(j: pointer.j + 1);
    case MatchDirection.Bottom:
      return pointer.copyWith(i: pointer.i + 1);
  }
}

bool _canSearchToDirection(
  List<List<Item>> field,
  Index from,
  MatchDirection direction,
  int matchesMinIndex,
) {
  switch (direction) {
    case MatchDirection.Left:
      return from.j >= matchesMinIndex;
    case MatchDirection.Top:
      return from.i >= matchesMinIndex;
    case MatchDirection.Right:
      final int lastColumnIndex = (field.getSafe(0)?.length ?? 1) - 1;
      return lastColumnIndex - from.j >= matchesMinIndex;
    case MatchDirection.Bottom:
      final int lastRowIndex = field.length - 1;
      return lastRowIndex - from.i >= matchesMinIndex;
  }
}

enum MatchDirection {
  Left,
  Top,
  Right,
  Bottom,
}
