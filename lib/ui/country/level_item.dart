import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/models/level.dart';

import '../../app/di.dart';

class LevelItem extends StatelessWidget {
  final Level level;

  LevelItem(this.level);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: ListTile(
        title: Text(level.name),
      ),
      onTap: () => di.navigation.openLevel(level),
    );
  }
}
