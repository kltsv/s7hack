import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';

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
    Level('Снайфедльс', GameState.empty, LevelStatus.available),
    Level('Фаградальсфьядль', GameState.empty, LevelStatus.unavailable),
    Level('Эйяфьядлайёкюдль', GameState.empty, LevelStatus.unavailable),
    Level('Хваннадальсхнукюр', GameState.empty, LevelStatus.unavailable),
  ],
);
