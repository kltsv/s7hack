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
      _countries = Countries({
        _initIceland.id: _initIceland,
        _initGonduras.id: _initGonduras,
        _initSlovenia.id: _initSlovenia,
        _initTrinidad.id: _initTrinidad,
      });
      await saveProgress();
    }
  }

  Future<void> updateCurrentCountry(String countryId) async {
    _currentCountryId = countryId;
    await saveProgress();
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
      'Как оформить визу',
      GameConfig(7, 6, 10),
      0,
      100,
      'https://официальный-визовый-центр.москва/blog/kak-oformit-vizu-v-islandiyu-v-moskve-poshagovaya-instruktsiya/',
    ),
    Level(
      'Фаградальсфьядль',
      'Учесть некоторые вещи к поездке',
      GameConfig(7, 6, 25),
      100,
      300,
      'https://mishka.travel/blog/index/node/id/3330-puteshestvie-v-islandiyu-jile-avia-avto/',
    ),
    Level(
      'Эйяфьядлайёкюдль',
      'Выбрать достопримечательности',
      GameConfig(8, 6, 40),
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

const _initGonduras = Country(
  'gonduras',
  'Гондурас',
  AppAssets.gondurasLogo,
  AppAssets.gondurasBackground,
  [
    Level(
      'Сан-Педро-Сула',
      'Как оформить визу',
      GameConfig(7, 6, 10),
      0,
      100,
      'https://visasam.ru/oformlenie/latamerica/nuznha-li-visa-v-gonduras.html',
    ),
    Level(
      'Пуэрто-Кортес',
      'Маршруты самостоятельного путешествия',
      GameConfig(7, 6, 25),
      100,
      300,
      'http://you4travel.ru/marshrut-samostoyatelnogo-puteshestviya-po-gondurasu/',
    ),
    Level(
      'Ла-Сейба',
      'Интересное в инстаграме',
      GameConfig(8, 6, 40),
      300,
      600,
      'https://www.instagram.com/explore/tags/гондурас/',
    ),
  ],
  0,
);

const _initSlovenia = Country(
  'slovenia',
  'Словения',
  AppAssets.sloveniaLogo,
  AppAssets.sloveniaBackground,
  [
    Level(
      'Постойна',
      'Оформить и получить визу',
      GameConfig(7, 6, 10),
      0,
      100,
      'https://visasam.ru/oformlenie/evropa/visa-v-sloveniyu.html',
    ),
    Level(
      'Шкоцьян',
      'Путеводитель с картой',
      GameConfig(7, 6, 25),
      100,
      300,
      'https://marinatravelblog.com/slovenia-putevoditel/',
    ),
    Level(
      'Крка',
      'Инстаграм',
      GameConfig(8, 6, 40),
      300,
      600,
      'https://www.instagram.com/explore/tags/словения/',
    ),
  ],
  0,
);

const _initTrinidad = Country(
  'trinidad',
  'Тринидад и Тобаго',
  AppAssets.trinidadLogo,
  AppAssets.trinidadBackground,
  [
    Level(
      'Сомбассон',
      'Едем в Тринидад и Тобаго – нужна ли виза',
      GameConfig(7, 6, 10),
      0,
      100,
      'https://vseovisah-ru.turbopages.org/vseovisah.ru/s/oformlenie/amerika/viza-v-trinidad-i-tobago.html',
    ),
    Level(
      'Ла-Лаха',
      'Всё об отдыхе',
      GameConfig(7, 6, 25),
      100,
      300,
      'https://travelask.ru/trinidad-and-tobago',
    ),
    Level(
      'Гуанапо',
      'Свежее в инстаграме',
      GameConfig(8, 6, 40),
      300,
      600,
      'https://www.instagram.com/explore/tags/тринидадитобаго/',
    ),
  ],
  0,
);
