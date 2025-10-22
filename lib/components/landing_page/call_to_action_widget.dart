import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class CallToActionWidget extends StatelessWidget {
  final double height;
  const CallToActionWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: height,
            child: FittedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://i.imgflip.com/77e8vi.png"),
                  ),
                  Text("CHIWI AI", style: TextStyle(fontSize: 50)),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            alignment: AlignmentGeometry.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ChiwiColors.MATCHA,
                padding: EdgeInsetsGeometry.only(
                  top: 25,
                  bottom: 25,
                  left: 150,
                  right: 150,
                ),
              ),
              onPressed: () {},
              child: Text(
                "Get Started",
                style: TextStyle(color: ChiwiColors.ALMOND, fontSize: 36),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
