import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/ui/home/country_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverGrid.count(
              crossAxisCount: 3,
              children: di.countryUseCase.countries
                  .map((country) => CountryItem(country: country))
                  .toList(),
            ),
          ),
        ],
      ),
    ));
  }
}
