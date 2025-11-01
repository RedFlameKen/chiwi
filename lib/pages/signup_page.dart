import 'package:chiwi/components/form/signup_form.dart';
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/input/text_input.dart';
import 'package:chiwi/pages/templates/two_section_page.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return TwoSectionPage(
      leftChild: SignupForm(),
      rightChild: ChiwiWidget(),
    );
  }
}
