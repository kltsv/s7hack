import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/ui/home/country_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(child: SizedBox(height: 100)),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              children: di.countryUseCase.countriesList
                  .map((country) => CountryItem(country: country))
                  .toList(),
            ),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
                child: Container(
                    width: 100,
                    height: 100,
                    child: Image.asset(AppAssets.s7logo))),
          )),
        ],
      ),
    ));
  }
}
