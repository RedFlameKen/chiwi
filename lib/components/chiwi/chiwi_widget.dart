import 'package:flutter/material.dart';

class ChiwiWidget extends StatelessWidget {
  final String? assetPath;
  const ChiwiWidget({super.key, this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage(assetPath ?? "lib/assets/chiwi3_updated.png"),
    );
  }
}
