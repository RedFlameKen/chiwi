import 'package:chiwi/components/ending_page/quiz_end_info.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class QuizScorePage extends StatelessWidget{
  const QuizScorePage({super.key});

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChiwiColors.ALMOND,
      body: Center(
        //this is the main green box
        child: FractionallySizedBox(
          widthFactor: 0.95,
          heightFactor: 0.95,
          child: Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ChiwiColors.PISTACHE,
              borderRadius: BorderRadius.circular(5)
            ),
            child: const QuizEndInfo(),
          ),
        ),
      ),
    );
  }
}