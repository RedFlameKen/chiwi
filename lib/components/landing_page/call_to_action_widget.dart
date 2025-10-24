import 'package:chiwi/pages/login_or_signup.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class CallToActionWidget extends StatelessWidget {
  final double height;
  const CallToActionWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      mainAxisAlignment: .spaceEvenly,
      crossAxisAlignment: .center,
      children: [
        Expanded(
          child: SizedBox(
            height: height,
            child: FittedBox(
              child: Column(
                mainAxisSize: .min,
                mainAxisAlignment: .spaceAround,
                children: [
                  Image(
                    fit: .cover,
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
                padding: .only(
                  top: 25,
                  bottom: 25,
                  left: 150,
                  right: 150,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                   MaterialPageRoute(
                    builder: (context) => LoginOrSignupPage(), //might need to change this so the button can be reused for other stuff
                    ),
                    );
              },
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
