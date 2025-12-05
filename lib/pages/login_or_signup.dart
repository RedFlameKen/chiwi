import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/landing_page/login_signup_widget.dart';
import 'package:chiwi/pages/templates/two_section_page.dart';
import 'package:flutter/material.dart';

class LoginOrSignupPage extends StatelessWidget {
  const LoginOrSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TwoSectionPage(
      leftChild: Column(
        mainAxisSize: .max,
        mainAxisAlignment: .center,
        children: [
          Spacer(flex: 1),
          Expanded(flex: 2, child: LoginSignupWidget()),
          Spacer(flex: 1),
        ],
      ),
      rightChild: Center(child: ChiwiWidget()),
    );
  }
}
