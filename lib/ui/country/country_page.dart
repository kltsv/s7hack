import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/country.dart';
import 'package:s7hack/ui/components/home_button.dart';
import 'package:s7hack/ui/country/level_item.dart';

class CountryPage extends StatefulWidget {
  final Country country;

  const CountryPage({
    Key? key,
    required this.country,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  @override
  void initState() {
    super.initState();
    di.countryUseCase.updateCurrentCountry(widget.country.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [const HomeButton()],
              expandedHeight: 200,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: ListTile(
                  title: Text(
                    widget.country.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Очков: ${widget.country.score}${widget.country.progress.round() == 0 ? ''
                        '' : ' (${widget.country.progress.round()}%)'}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(color: Colors.white70, fontSize: 10),
                  ),
                ),
                background: Container(
                  foregroundDecoration: BoxDecoration(color: Colors.black54),
                  child: Image.asset(
                    widget.country.backgroundAsset,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 8)),
            SliverToBoxAdapter(
              child: Column(
                  children: widget.country.levels
                      .map((level) =>
                          LevelItem(countryId: widget.country.id, level: level))
                      .toList()),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverToBoxAdapter(
              child: InkResponse(
                  child: Image.asset(AppAssets.ticket),
                  onTap: () => di.navigation.openLink(AppAssets.s7Url)),
            ),
            SliverToBoxAdapter(
              child: Image.asset(AppAssets.ticket),
            ),
          ],
        ),
      ),
    );
  }
}
