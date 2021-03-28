import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:s7hack/domain/cache/cache.dart';
import 'package:s7hack/domain/country/country_usecase.dart';
import 'package:s7hack/domain/engine/engine.dart';
import 'package:s7hack/domain/engine/engine_holder.dart';

import 'navigation/navigation.dart';

final _navigationKey = GlobalKey<NavigatorState>();

final _navigationProvider =
    Provider.autoDispose((_) => Navigation(_navigationKey));
final _cacheProvider = Provider((_) => Cache());
final _countriesRepoProvider = Provider((_) => CountryUseCase());
final _engineProvider = Provider((_) => EngineHolder());

final di = ProviderContainer();

extension DIProvider on ProviderContainer {
  Navigation get navigation => read(_navigationProvider);

  Cache get cache => read(_cacheProvider);

  CountryUseCase get countryUseCase => read(_countriesRepoProvider);

  EngineHolder get engineHolder => read(_engineProvider);

  Engine get engine => engineHolder.engine;
}
