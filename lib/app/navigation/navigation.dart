import 'package:flutter/material.dart';

import '../logger.dart';

class Navigation {
  final GlobalKey<NavigatorState> navigationKey;

  const Navigation(this.navigationKey);

  void pushNamed(String route, {Object? args}) {
    logger.info('Push route: $route${args != null ? ', $args' : ''}');
    _state?.pushNamed(route, arguments: args);
  }

  void popToHome() {
    logger.info('Pop home');
    _state?.popUntil((route) => route.isFirst);
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
