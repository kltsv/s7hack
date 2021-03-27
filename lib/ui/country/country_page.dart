import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: const HomeButton(),
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(widget.country.name),
              ),
            ),
            SliverFillRemaining(
              child: Column(
                  children: widget.country.levels
                      .map((level) => LevelItem(level))
                      .toList()),
            )
          ],
        ),
      ),
    );
  }
}
