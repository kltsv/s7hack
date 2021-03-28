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
        child: GridTile(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Text('${country.progress.toInt()}%')],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0)
                .copyWith(bottom: 20),
            child: Image.asset(
              country.imageAsset,
              fit: BoxFit.contain,
            ),
          ),
          footer: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              country.name,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
      onTap: () => di.navigation.openCountry(country),
    );
  }
}
