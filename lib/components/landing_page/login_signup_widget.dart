import 'package:chiwi/pages/login_page.dart';
import 'package:chiwi/pages/signup_page.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class LoginSignupWidget extends StatelessWidget {
  const LoginSignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ChiwiColors.MATCHA,
            padding: .only(top: 25, bottom: 25, left: 150, right: 150),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Text(
            "Log In",
            style: TextStyle(color: ChiwiColors.ALMOND, fontSize: 36),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ChiwiColors.MATCHA,
            padding: .only(top: 25, bottom: 25, left: 150, right: 150),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(color: ChiwiColors.ALMOND, fontSize: 36),
          ),
        ),
      ],
    );
  }
}
