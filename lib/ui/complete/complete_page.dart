import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/domain/engine/models/game_state.dart';
import 'package:clipboard/clipboard.dart';


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
                GestureDetector(
                  child: Positioned.fill(
                      child: Align(
                        child: Container(
                          padding: EdgeInsets.all(24),
                          child: Icon(Icons.share),
                        ),
                        alignment: Alignment.topRight,
                      ),
                  ),
                  onTap: () {
                    FlutterClipboard.copy('Я набрал ${state.score} очков в игре от S7, попробуй и ты: http://bit.ly/s7match3');
                    final snack = SnackBar(content: Text('Результаты скопированы в буфер обмена'));
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                  },
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
