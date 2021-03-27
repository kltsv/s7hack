import 'package:flutter/material.dart';

import '../logger.dart';

class Navigation {
  final GlobalKey<NavigatorState> navigationKey;

  const Navigation(this.navigationKey);

  void pushNamed(String route, {Object? args}) {
    final state = navigationKey.currentState;
    if (state == null) {
      logger.warning('Could not push route "$route": navigation state is null');
      return;
    }
    logger.info('Push route: $route');
    state.pushNamed(route, arguments: args);
  }

  void pop() {
    final state = navigationKey.currentState;
    if (state == null) {
      logger.warning('Could not pop route: navigation state is null');
      return;
    }
    logger.info('Pop route');
    state.pop();
  }
}
