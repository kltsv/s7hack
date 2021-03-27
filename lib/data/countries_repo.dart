import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/models/diff.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/domain/engine/models/item.dart';
import 'package:s7hack/domain/engine/models/item_type.dart';

class CountriesRepo {
  List<Country> _countries = [_iceland]; // mocks

  List<Country> get countries => _countries;

  Country? get current => _countries[0];
}

const _iceland = Country(
  'island',
  'Исландия',
  AppAssets.earthLogo, // TODO replace
  [
    Level('Снайфедльс', _mockedLevelState, LevelStatus.available),
    Level('Фаградальсфьядль', GameState.empty, LevelStatus.unavailable),
    Level('Эйяфьядлайёкюдль', GameState.empty, LevelStatus.unavailable),
    Level('Хваннадальсхнукюр', GameState.empty, LevelStatus.unavailable),
  ],
);

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
    Diff.empty);
