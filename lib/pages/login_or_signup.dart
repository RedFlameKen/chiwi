import 'package:chiwi/components/landing_page/call_to_action_widget_for_loginsignup.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class LoginOrSignupPage extends StatelessWidget {
  const LoginOrSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
  
    final screenHeight = MediaQuery.of(context).size.height;
    final ctaHeight = screenHeight;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ChiwiColors.VANILLA, ChiwiColors.ALMOND],
          ),
        ),
        child: ListView(
          children: [
            CallToActionWidget(height: ctaHeight), //remind me to rename this class to something else to prevent confusion
            Text("There was a youtube link here. Its gone now"),
          ],
        ),
      ),
    );
  }
}