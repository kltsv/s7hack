import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:clipboard/clipboard.dart';
import 'package:s7hack/ui/complete/complete_args.dart';


class CompletePage extends StatelessWidget {
  final CompleteArgs args;

  const CompletePage({Key? key, required this.args}) : super(key: key);
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
                      Container(
                          padding: EdgeInsets.all(36),
                          child: Image.asset(AppAssets.viking),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 24)
                      ),
                      Text("Открыт материал \"${args.level.description}\"!", style: Theme.of(context)
                          .textTheme
                          .subtitle2),
                      TextButton(
                        onPressed: () {
                          di.navigation.openLink(args.level.bonusUrl);
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(vertical: 16.0),
                          child: Text('Смотреть статью'),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 48)
                      ),
                      Text(
                        'Заработано очков',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            ?.copyWith(fontSize: 14),
                      ),
                      Text('${args.gameState.score}',
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Positioned.fill(
                      child: Align(
                        child: Container(
                          padding: EdgeInsets.all(36),
                          child: Icon(Icons.share),
                        ),
                        alignment: Alignment.topRight,
                      ),
                  ),
                  onTap: () {
                    FlutterClipboard.copy('Я набрал ${args.gameState.score} очков в игре от S7, попробуй и ты: http://bit.ly/s7match3');
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
