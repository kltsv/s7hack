import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/app/logger.dart';
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
    logger.info('Add score: $add, total: ${country.score + add}');
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
    Level(
      'Снайфедльс',
      'Оформить визу',
      GameConfig(7, 5, 5),
      0,
      100,
      'https://официальный-визовый-центр.москва/blog/kak-oformit-vizu-v-islandiyu-v-moskve-poshagovaya-instruktsiya/',
    ),
    Level(
      'Фаградальсфьядль',
      'Учесть некоторые вещи к поездке',
      GameConfig(7, 5, 30),
      100,
      300,
      'https://mishka.travel/blog/index/node/id/3330-puteshestvie-v-islandiyu-jile-avia-avto/',
    ),
    Level(
      'Эйяфьядлайёкюдль',
      'Выбрать достопримечательности',
      GameConfig(7, 6, 40),
      300,
      600,
      'https://www.onetwotrip.com/ru/blog/iceland/6-reasons-go-to-iceland/',
    ),
    Level(
      'Хваннадальсхнукюр',
      'Подобрать инстаграммные ракурсы',
      GameConfig(8, 6, 50),
      600,
      1000,
      'https://www.instagram.com/explore/tags/исландия/',
    ),
  ],
  0,
);
