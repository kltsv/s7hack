import 'package:flutter/material.dart';
import 'package:s7hack/app/navigation/routes.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';
import 'package:s7hack/ui/complete/complete_args.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../ui/level/level_page.dart';
import '../logger.dart';

class Navigation {
  final GlobalKey<NavigatorState> navigationKey;

  const Navigation(this.navigationKey);

  void openCountry(Country country) =>
      _pushNamed(Routes.country, args: country);

  void openLevel(Level level, {bool fromRoot = false, bool replace = false}) =>
      replace
          ? _replaceNamed(
              Routes.level,
              args: LevelPage.args(level, fromRoot: fromRoot),
            )
          : _pushNamed(
              Routes.level,
              args: LevelPage.args(level, fromRoot: fromRoot),
            );

  void showCompleteGame(CompleteArgs args) =>
      _pushNamed(Routes.completeGame, args: args);

  void popToHome() {
    logger.info('Pop home');
    _state?.popUntil((route) => route.isFirst);
  }

  Future<void> openLink(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    }
  }

  void _pushNamed(String route, {Object? args}) {
    logger.info('Push route: $route${args != null ? ', $args' : ''}');
    _state?.pushNamed(route, arguments: args);
  }

  void _replaceNamed(String route, {Object? args}) {
    logger.info('Replace route: $route${args != null ? ', $args' : ''}');
    _state?.pushReplacementNamed(route, arguments: args);
  }

  void pop() {
    logger.info('Pop route');
    _state?.pop();
  }

  NavigatorState? get _state {
    final state = navigationKey.currentState;
    if (state == null) {
      logger.warning('Could not get navigation state: null');
      return null;
    }
    return state;
  }
}
