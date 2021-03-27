import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:s7hack/data/countries_repo.dart';
import 'package:s7hack/domain/cache/cache.dart';

import 'navigation/navigation.dart';

final _navigationKey = GlobalKey<NavigatorState>();

final _navigationProvider =
    Provider.autoDispose((_) => Navigation(_navigationKey));
final _cacheProvider = Provider((_) => Cache());
final _countriesRepoProvider = Provider((_) => CountriesRepo());

final di = ProviderContainer();

extension DIProvider on ProviderContainer {
  Navigation get navigation => read(_navigationProvider);

  Cache get cache => read(_cacheProvider);

  CountriesRepo get countriesRepo => read(_countriesRepoProvider);
}
