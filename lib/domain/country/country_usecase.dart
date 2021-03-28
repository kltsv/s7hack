import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/countries.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/domain/engine/models/game_config.dart';

class CountryUseCase {
  static const _countriesKey = 'countries';
  static const _currentCountryKey = 'currentCountry';

  String? _currentCountryId;
  Countries _countries = Countries.empty;

  Map<String, Country> get countries => _countries.countries;

  List<Country> get countriesList => _countries.countries.values.toList();

  Country? get current => _countries.countries[_currentCountryId];

  Future<void> addScore(String countryId, int add) async {
    final country = countries[countryId]!;
    _countries.countries[countryId] =
        country.copyWith(score: country.score + add);
    _countries = _countries.copyWith(countries: _countries.countries);
    for (var i = 0; i < country.levels.length; i++) {
      if (country.levels[i].scoreToOpen <
              _countries.countries[countryId]!.score &&
          country.levels[i].status != LevelStatus.available) {
        country.levels[i] =
            country.levels[i].copyWith(status: LevelStatus.available);
      }
    }
    await saveProgress();
  }

  Future<void> init() async {
    final raw = di.cache.load(_countriesKey);
    final id = di.cache.load(_currentCountryKey);
    if (raw != null && id != null) {
      _countries = Countries.fromJson(raw);
      _currentCountryId = id['id'];
    } else {
      // initial data
      _currentCountryId = _initIceland.id;
      _countries = Countries({_initIceland.id: _initIceland});
      await saveProgress();
    }
  }

  Future<void> saveProgress() async {
    await di.cache
        .save(_currentCountryKey, <String, dynamic>{'id': _currentCountryId});
    await di.cache.save(_countriesKey, _countries.toJson());
  }
}

const _initIceland = Country(
  'iceland',
  'Исландия',
  AppAssets.icelandLogo,
  AppAssets.icelandBackground,
  [
    Level('Снайфедльс', GameConfig(7, 5, 20), LevelStatus.available, 0),
    Level(
        'Фаградальсфьядль', GameConfig(7, 5, 30), LevelStatus.unavailable, 100),
    Level(
        'Эйяфьядлайёкюдль', GameConfig(7, 6, 40), LevelStatus.unavailable, 300),
    Level(
      'Хваннадальсхнукюр',
      GameConfig(8, 6, 50),
      LevelStatus.unavailable,
      600,
    ),
  ],
  0,
);
