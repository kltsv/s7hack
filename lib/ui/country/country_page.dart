import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/models/country.dart';
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
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
    );
  }
}
