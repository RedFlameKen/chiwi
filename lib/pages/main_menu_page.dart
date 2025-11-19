import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/pages/quiz_page.dart';
import 'package:chiwi/pages/templates/two_section_page.dart';
import 'package:flutter/material.dart';

class MainMenuPage extends StatelessWidget {
  MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TwoSectionPage(
      leftChild: Column(
        mainAxisSize: .min,
        mainAxisAlignment: .center,
        children: [
          Spacer(flex: 1),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisSize: .max,
              mainAxisAlignment: .spaceEvenly,
              children: [
                Button(
                  text: "View Reviewers",
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return QuizPage();
                        },
                      ),
                    );
                  },
                ),
                Button(text: "New Reviewer", onPressed: () {}),
              ],
            ),
          ),
          Spacer(flex: 1),
        ],
      ),
      rightChild: ChiwiWidget(),
    );
  }
}
