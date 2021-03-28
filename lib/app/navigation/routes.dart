import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:s7hack/app/navigation/fade_route.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:s7hack/ui/complete/complete_page.dart';
import 'package:s7hack/ui/country/country_page.dart';
import 'package:s7hack/ui/home/home_page.dart';
import 'package:s7hack/ui/level/level_page.dart';

import '../../ui/counter/counter_page.dart';
import '../../ui/level/level_page.dart';

class Routes {
  const Routes._();

  static const home = '/';
  static const country = '/country';
  static const level = '/level';
  static const counter = '/counter';
  static const completeGame = '/completeGame';

  static final table = <String, Route Function(RouteSettings)>{
    Routes.home: (settings) => _defaultRoute(settings, (context) => HomePage()),
    Routes.country: (settings) => _defaultRoute(settings,
        (context) => CountryPage(country: settings.arguments as Country)),
    Routes.level: (settings) {
      var startedFromRoot = false;
      if (settings.arguments is Map<String, dynamic>) {
        final map = settings.arguments as Map<String, dynamic>;
        startedFromRoot = LevelPage.parseFromRoot(map);
      }
      if (startedFromRoot) {
        return _fadeRoute(settings, (context) {
          final map = settings.arguments as Map<String, dynamic>;
          return LevelPage(
            level: LevelPage.parseLevel(map),
            fromRoot: LevelPage.parseFromRoot(map),
          );
        });
      } else {
        return _defaultRoute(settings, (context) {
          final map = settings.arguments as Map<String, dynamic>;
          return LevelPage(
            level: LevelPage.parseLevel(map),
            fromRoot: LevelPage.parseFromRoot(map),
          );
        });
      }
    },
    Routes.counter: (settings) =>
        _defaultRoute(settings, (context) => CounterPage()),
    Routes.completeGame: (settings) => _defaultDialogRoute(settings,
        (context) => CompletePage(state: settings.arguments as GameState)),
  };

  static Route<T> _defaultRoute<T>(
    RouteSettings routeSettings,
    WidgetBuilder builder, {
    bool modal = false,
  }) {
    if (kIsWeb) {
      return _fadeRoute(routeSettings, builder);
    } else {
      return MaterialPageRoute<T>(
        settings: routeSettings,
        builder: builder,
        fullscreenDialog: modal,
      );
    }
  }

  static Route<T> _defaultDialogRoute<T>(
    RouteSettings routeSettings,
    WidgetBuilder builder,
  ) =>
      DialogRoute<T>(
        builder: builder,
        settings: routeSettings,
        barrierDismissible: false,
      );

  static Route<T> _fadeRoute<T>(
    RouteSettings routeSettings,
    WidgetBuilder builder,
  ) =>
      FadePageRoute<T>(
        builder: builder,
        settings: routeSettings,
      );

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = Routes.table[settings.name];
    if (route == null) {
      throw Exception('Unknown route: $settings');
    }
    return route(settings);
  }
}

class DialogRoute<T> extends PopupRoute<T> {
  static RoutePageBuilder _defaultPageBuilder(WidgetBuilder builder) =>
      (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          Builder(builder: builder);

  DialogRoute({
    required WidgetBuilder builder,
    bool barrierDismissible = true,
    String? barrierLabel,
    Color barrierColor = const Color(0x80000000),
    Duration transitionDuration = const Duration(milliseconds: 200),
    RouteTransitionsBuilder? transitionBuilder,
    RouteSettings? settings,
  })  : _pageBuilder = _defaultPageBuilder(builder),
        _barrierDismissible = barrierDismissible,
        _barrierLabel = barrierLabel,
        _barrierColor = barrierColor,
        _transitionDuration = transitionDuration,
        _transitionBuilder = transitionBuilder,
        super(settings: settings);

  final RoutePageBuilder _pageBuilder;

  @override
  bool get barrierDismissible => _barrierDismissible;
  final bool _barrierDismissible;

  @override
  String? get barrierLabel => _barrierLabel;
  final String? _barrierLabel;

  @override
  Color get barrierColor => _barrierColor;
  final Color _barrierColor;

  @override
  Duration get transitionDuration => _transitionDuration;
  final Duration _transitionDuration;

  final RouteTransitionsBuilder? _transitionBuilder;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Semantics(
      child: _pageBuilder(context, animation, secondaryAnimation),
      scopesRoute: true,
      explicitChildNodes: true,
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      _transitionBuilder?.call(context, animation, secondaryAnimation, child) ??
      FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.linear,
          ),
          child: child); // Some default transition

}
