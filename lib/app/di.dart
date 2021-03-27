import 'package:flutter/widgets.dart';
import 'package:riverpod/riverpod.dart';
import 'package:s7hack/domain/cache/cache.dart';

import 'navigation/navigation.dart';

final _navigationKey = GlobalKey<NavigatorState>();

/// Core
@visibleForTesting
final navigationProvider =
    Provider.autoDispose((_) => Navigation(_navigationKey));
@visibleForTesting
final cacheProvider = Provider((_) => Cache());

final di = ProviderContainer();

extension DIProvider on ProviderContainer {
  Navigation get navigation => read(navigationProvider);

  Cache get cache => read(cacheProvider);
}
