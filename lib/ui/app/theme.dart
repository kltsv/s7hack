import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';

class AppTheme {
  static ThemeData get(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      primaryColor: AppAssets.accentColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        textTheme: theme.appBarTheme.textTheme?.copyWith(
          headline6: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  const AppTheme._();
}
