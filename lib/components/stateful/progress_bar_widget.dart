import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ProgressBarWidget extends StatefulWidget {
  const ProgressBarWidget({super.key});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  double _value = 0;

  void setValue(double value) {
    setState(() {
      _value = value;
    });
  }

  void incrementValue() {
    setState(() {
      _value += 0.1;
    });
  }

  double getValue() {
    return _value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: 30,
          child: LinearProgressIndicator(
            //value: (_currentQuestionIndex + 1) / questions.length,
            value: _value,
            backgroundColor: ChiwiColors.SERENE_2,
            valueColor: AlwaysStoppedAnimation<Color>(ChiwiColors.PISTACHE),
          ),
        ),
      ],
    );
  }
}
