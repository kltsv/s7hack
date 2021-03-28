import 'package:flutter/material.dart';
import 'package:s7hack/app/assets/assets.dart';
import 'package:s7hack/app/di.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(AppAssets.earthLogo),
      ),
      onTap: () => di.navigation.popToHome(),
    );
  }
}
