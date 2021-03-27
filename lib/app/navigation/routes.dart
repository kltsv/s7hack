import 'package:flutter/material.dart';
import 'package:s7hack/ui/counter/counter_page.dart';
import 'package:s7hack/ui/country/country_page.dart';

class Routes {
  const Routes._();

  static const home = '/';
  static const country = "/country";
  static final table = <String, Route Function(RouteSettings)>{
    Routes.home: (settings) =>
        _defaultRoute(settings, (context) => CounterPage()),
    Routes.country: (settings) =>
        _defaultRoute(settings, (context) => CountryPage())
  };

  static Route<T> _defaultRoute<T>(
    RouteSettings routeSettings,
    WidgetBuilder builder, {
    bool modal = false,
  }) =>
      MaterialPageRoute<T>(
        settings: routeSettings,
        builder: builder,
        fullscreenDialog: modal,
      );

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = Routes.table[settings.name];
    if (route == null) {
      throw Exception('Unknown route: $settings');
    }
    return route(settings);
  }
}
