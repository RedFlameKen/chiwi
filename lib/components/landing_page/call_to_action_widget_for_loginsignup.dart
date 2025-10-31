//I've fucked this up tremendously I'll just fix it tomorrow or some other day
import 'package:chiwi/pages/quiz_page.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class CallToActionWidget extends StatelessWidget { //remind me to rename this class to something else to prevent confusion
  final double height;
  const CallToActionWidget({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Column( 
      mainAxisSize: .min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            alignment: Alignment.centerLeft,
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
                    builder: (context) => QuizPage(), //temporary for testing
                    ),
                    );
              },
              child: Text(
                "Log In",
                style: TextStyle(color: ChiwiColors.ALMOND, fontSize: 36),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
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
                // Navigator.push(
                //   context,
                //    MaterialPageRoute(
                //     builder: (context) => SignupPage(), 
                //     ),
                //     );
              },
              child: Text(
                "Sign Up",
                style: TextStyle(color: ChiwiColors.ALMOND, fontSize: 36),
              ),
            ),
        ),
      ],
    );
  }
}
