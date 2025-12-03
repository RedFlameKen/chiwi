import 'package:chiwi/components/form/login_form.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/pages/templates/two_section_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return TwoSectionPage(
      leftChild: LoginForm(),
      rightChild: ChiwiWidget(),
    );
  }
}
