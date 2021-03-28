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
      theme: ThemeData(
        primaryColor: AppAssets.accentColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      navigatorKey: di.navigation.navigationKey,
      initialRoute: Routes.home,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
