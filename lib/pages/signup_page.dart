import 'package:chiwi/components/chiwi/chiwi_widget.dart';
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
      leftChild: Column(
        children: [
          Row(
            children: [
            Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                "Create a Username and Password",
                textAlign: .center,
                style: TextStyle(fontWeight: .bold, fontSize: 36),
                ),
            ),
            Spacer(),
            ],
          ),
          Column(
            mainAxisSize: .max,
            mainAxisAlignment: .spaceEvenly,
            children: [
              TextField(),
              TextField(),
              TextField()
            ],
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Create Account"),
            )
          )
        ],
      ),
      rightChild: ChiwiWidget()
    );
  }

}
