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
  AppAssets.icelandLogo,
  AppAssets.icelandBackground,
  [
    Level('Снайфедльс', GameConfig(8, 6, 20), LevelStatus.available, 0),
    Level(
        'Фаградальсфьядль', GameConfig(3, 3, 25), LevelStatus.unavailable, 50),
    Level(
        'Эйяфьядлайёкюдль', GameConfig(3, 3, 35), LevelStatus.unavailable, 150),
    Level('Хваннадальсхнукюр', GameConfig(3, 3, 50), LevelStatus.unavailable,
        500),
  ],
  0,
);
