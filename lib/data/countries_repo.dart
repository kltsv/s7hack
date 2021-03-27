import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';

class CountriesRepo {
  List<Country> _countries = [_iceland]; // mocks

  List<Country> get countries => _countries;
}

const _iceland = Country(
  'island',
  'Исландия',
  AppAssets.earthLogo, // TODO replace
  [
    Level('Снайфедльс'),
    Level('Фаградальсфьядль'),
    Level('Эйяфьядлайёкюдль'),
    Level('Хваннадальсхнукюр'),
  ],
);
