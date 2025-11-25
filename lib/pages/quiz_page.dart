import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/quiz_page/review_listener_widget.dart';

class QuizPage extends StatelessWidget {
  final String intialQuestion;
  const QuizPage({super.key, required this.intialQuestion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisSize: .max,
              children: [
                Expanded(
                  child: ReviewListenerWidget(initialQuestion: intialQuestion),
                ),
                ProgressBarWidget(direction: .vertical),
              ],
            ),
          ),
          Expanded(child: ChiwiWidget()),
        ],
      ),
    );
  }
}
