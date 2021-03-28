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
        final size = MediaQuery.of(context).size;
        print('size: $size');
        if (size.width > size.height) {
          // для лендскейпа показываем игру по центру
          return Row(
            children: [
              Spacer(flex: 7),
              Expanded(flex: 7, child: child!),
              Spacer(flex: 7),
            ],
          );
        }
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
