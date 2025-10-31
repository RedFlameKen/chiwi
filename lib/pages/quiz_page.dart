import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/quiz_page/review_listener_widget.dart';

class QuizPage extends StatelessWidget{
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: ReviewListenerWidget()),
        Expanded(child: ProgressBarWidget()),
        Expanded(child: ChiwiWidget())
      ],
    );
  }

}
