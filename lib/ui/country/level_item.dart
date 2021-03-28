import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/country/models/level.dart';

import '../../app/di.dart';

class LevelItem extends StatelessWidget {
  final Level level;

  LevelItem(this.level);

  @override
  Widget build(BuildContext context) {
    final levelStatus = di.countryUseCase.current?.currentLevel.status ??
        LevelStatus.unavailable;
    return InkResponse(
      child: Card(
        child: ListTile(
          leading: levelStatus == LevelStatus.completed
              ? Icon(Icons.done, color: AppAssets.accentColor)
              : null,
          title: Text(
            level.description,
            style:
                Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
          subtitle: Text(
            'Уровнь: ${level.name}',
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.black26),
          ),
          trailing: levelStatus == LevelStatus.available
              ? IconButton(
                  icon: Icon(
                    Icons.play_arrow,
                    color: AppAssets.accentColor,
                  ),
                  onPressed: () {
                    di.navigation.openLevel(level);
                  })
              : null,
        ),
      ),
      onTap: levelStatus == LevelStatus.completed
          ? () => di.navigation.openLink(level.bonusUrl)
          : null,
    );
  }
}
