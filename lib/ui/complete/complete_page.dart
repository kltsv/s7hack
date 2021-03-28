import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';

class CompletePage extends StatelessWidget {
  final GameState state;

  const CompletePage({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 64.0),
      child: Material(
        color: Colors.transparent,
        child: Card(
          child: Container(
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Заработано очков',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 16),
                      ),
                      Text('${state.score}',
                          style: Theme.of(context).textTheme.headline4),
                    ],
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              di.navigation.popToHome();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text('Домой'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              final country = di.countryUseCase.current;
                              if (country != null) {
                                di.navigation.pop();
                                di.navigation.openLevel(country.currentLevel,
                                    replace: true);
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Text('Дальше'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
