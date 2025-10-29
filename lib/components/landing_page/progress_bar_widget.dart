import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ProgressBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: 20,
          child: LinearProgressIndicator(
            //value: (_currentQuestionIndex + 1) / questions.length,
            backgroundColor: ChiwiColors.MATCHA,
            valueColor: AlwaysStoppedAnimation<Color>(ChiwiColors.CHAI),
          ),
        ),
      ]
    );
  }
}
