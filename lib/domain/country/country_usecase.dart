import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/countries.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/models/game_config.dart';

class CountryUseCase {
  static const _countriesKey = 'countries';

  Countries _countries = Countries.empty;

  List<Country> get countries => _countries.countries;

  Country? get current => _countries.countries[0];

  Future<void> init() async {
    final raw = di.cache.load(_countriesKey);
    if (raw != null) {
      _countries = Countries.fromJson(raw);
    } else {
      // initial data
      _countries = Countries([_initIceland]);
    }
  }

  Future<void> saveProgress() =>
      di.cache.save(_countriesKey, _countries.toJson());
}

const _initIceland = Country(
  'island',
  'Исландия',
  AppAssets.icelandLogo,
  AppAssets.icelandBackground,
  [
    Level('Снайфедльс', GameConfig(8, 6, 15), LevelStatus.available, 0),
    Level(
        'Фаградальсфьядль', GameConfig(3, 3, 25), LevelStatus.unavailable, 50),
    Level(
        'Эйяфьядлайёкюдль', GameConfig(3, 3, 40), LevelStatus.unavailable, 200),
    Level(
      'Хваннадальсхнукюр',
      GameConfig(3, 3, 60),
      LevelStatus.unavailable,
      600,
    ),
  ],
  0,
);
