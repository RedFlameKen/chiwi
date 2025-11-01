import 'package:chiwi/components/landing_page/chiwi_widget.dart';
import 'package:chiwi/components/landing_page/login_signup_widget.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class LoginOrSignupPage extends StatelessWidget {
  const LoginOrSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ChiwiColors.VANILLA, ChiwiColors.ALMOND],
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: .infinity,
                color: ChiwiColors.ALMOND,
                child: Column(
                  mainAxisSize: .max,
                  mainAxisAlignment: .center,
                  children: [
                    Spacer(flex: 1),
                    Expanded(flex: 2, child: LoginSignupWidget()),
                    Spacer(flex: 1),
                  ],
                ),
              ),
            ),
            Expanded(child: ChiwiWidget()),
          ],
        ),
      ),
    );
  }
}
