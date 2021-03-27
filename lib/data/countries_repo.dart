import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/models/game_config.dart';

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
    Level('Снайфедльс', GameConfig(3, 3), LevelStatus.available),
    Level('Фаградальсфьядль', GameConfig(3, 3), LevelStatus.unavailable),
    Level('Эйяфьядлайёкюдль', GameConfig(3, 3), LevelStatus.unavailable),
    Level('Хваннадальсхнукюр', GameConfig(3, 3), LevelStatus.unavailable),
  ],
);
