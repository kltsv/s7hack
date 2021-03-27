import 'package:flutter/material.dart';

import '../../app/assets/assets.dart';
import '../../app/di.dart';
import '../../app/navigation/routes.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppAssets.appName,
      builder: (context, child) {
        return child!;
      },
      navigatorKey: di.navigation.navigationKey,
      initialRoute: Routes.counter,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
