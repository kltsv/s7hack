import 'package:flutter/material.dart';
import 'package:s7hack/domain/country/iceland_data.dart';

import 'country_level_item.dart';

class CountryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    throw _CountryPageState();
  }
}

class _CountryPageState extends State<CountryPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: icelandData.length,
        itemBuilder: (BuildContext context, int index) {
          return CountryLevelItem(icelandData[index]);
        }
    );
  }
}
