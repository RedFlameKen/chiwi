import 'package:flutter/material.dart';

class ChiwiWidget extends StatelessWidget {
  const ChiwiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(image: NetworkImage("https://i.imgflip.com/77e8vi.png"));
  }
}
