import 'package:flutter/material.dart';
import 'package:s7hack/app/di.dart';
import 'package:s7hack/domain/country/models/country.dart';

class CountryItem extends StatelessWidget {
  final Country country;

  const CountryItem({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            children: [
              Image.asset(
                country.imageAsset,
              ),
              Text(country.name),
            ],
          ),
        ),
      ),
      onTap: () => di.navigation.openCountry(country),
    );
  }
}
