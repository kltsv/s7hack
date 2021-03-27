import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/country_level.dart';

class CountryLevelItem extends StatelessWidget {

  final CountryLevel countryLevel;

  CountryLevelItem(this.countryLevel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(countryLevel.text),
    );
  }
}
