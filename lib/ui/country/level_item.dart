import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/domain/country/models/level.dart';

import '../../app/di.dart';

class LevelItem extends StatelessWidget {
  final String countryId;
  final Level level;

  const LevelItem({
    Key? key,
    required this.countryId,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final country = di.countryUseCase.countries[countryId]!;
    final levelStatus = level.status(country.score);
    return InkResponse(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Card(
          elevation: levelStatus == LevelStatus.available
              ? 3
              : levelStatus == LevelStatus.completed
                  ? 1
                  : 0,
          child: ListTile(
            leading: levelStatus == LevelStatus.completed
                ? Icon(Icons.done, color: AppAssets.accentColor)
                : null,
            title: Text(
              levelStatus == LevelStatus.completed
                  ? level.description
                  : 'Уровнь: ${level.name}',
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    fontSize: 16,
                    color: levelStatus == LevelStatus.unavailable
                        ? Colors.black12
                        : null,
                  ),
            ),
            subtitle: levelStatus == LevelStatus.unavailable
                ? null
                : Text(
                    levelStatus == LevelStatus.completed
                        ? 'Уровнь: ${level.name}'
                        : levelStatus == LevelStatus.available
                            ? 'Пройдите, чтобы открыть бонус'
                            : '',
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                          color: levelStatus == LevelStatus.unavailable
                              ? Colors.black12
                              : Colors.black26,
                        ),
                  ),
            trailing: levelStatus != LevelStatus.unavailable
                ? IconButton(
                    icon: Icon(
                      Icons.play_arrow,
                      color: AppAssets.accentColor,
                      size: 36,
                    ),
                    onPressed: () => di.navigation.openLevel(level))
                : null,
          ),
        ),
      ),
      onTap: levelStatus == LevelStatus.completed
          ? () => di.navigation.openLink(level.bonusUrl)
          : levelStatus == LevelStatus.available
              ? () => di.navigation.openLevel(level)
              : null,
    );
  }
}
