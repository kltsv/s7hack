import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/models/level.dart';

class LevelItem extends StatelessWidget {
  final Level level;

  LevelItem(this.level);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(level.name),
    );
  }
}
