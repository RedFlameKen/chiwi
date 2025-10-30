import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget{
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProgressBarWidget(),
      ),
    );
  }

}
