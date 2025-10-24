import 'package:chiwi/components/landing_page/call_to_action_widget.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class LoginOrSignupPage extends StatelessWidget {
  const LoginOrSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("CHIWI AI", style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: ChiwiColors.CHAI,
    );
    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = appBar.preferredSize.height;
    final ctaHeight = screenHeight - appBarHeight;
    return Scaffold(
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ChiwiColors.VANILLA, ChiwiColors.ALMOND],
          ),
        ),
        child: ListView(
          children: [
            CallToActionWidget(height: ctaHeight),
            Text("breh"),
          ],
        ),
      ),
    );
  }
}

//Just copy pasted landing_page.dart for now