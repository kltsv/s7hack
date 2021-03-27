import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/models/country.dart';

import '../../app/di.dart';
import '../../app/logger.dart';
import 'app.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    logger.info('Initializing');

    await di.cache.init();

    logger.info('Initialized');
    setState(() {
      _initialized = true;
    });

    WidgetsBinding.instance?.addPostFrameCallback((_) => _afterInit());
  }

  void _afterInit() {
    final currentCountry = di.countriesRepo.current;
    if (currentCountry != null) {
      final level = currentCountry.currentLevel;
      if (level != null) {
        di.navigation.openLevel(level);
      }
    }
  }

  @override
  void dispose() {
    di.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _initialized ? App() : _Splash();
  }
}

class _Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Material(
        child: Container(
          child: const Center(child: CircularProgressIndicator()),
        ),
      );
}
