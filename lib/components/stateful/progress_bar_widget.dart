import 'package:chiwi/enum/direction.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ProgressBarWidget extends StatefulWidget {
  final Direction direction;
  const ProgressBarWidget({super.key, this.direction = .horizontal});

  @override
  State<ProgressBarWidget> createState() => _ProgressBarWidgetState();
}

class _ProgressBarWidgetState extends State<ProgressBarWidget> {
  double _value = 0;

  _ProgressBarWidgetState();

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

  Widget createProgressIndicator(){
    return Expanded(
      child: LinearProgressIndicator(
        minHeight: 30,
        //value: (_currentQuestionIndex + 1) / questions.length,
        value: _value,
        backgroundColor: ChiwiColors.SERENE_2,
        valueColor: AlwaysStoppedAnimation<Color>(ChiwiColors.PISTACHE),
      ),
    );
  }

  Widget buildBar(){
    Widget bar = createProgressIndicator();
    Direction direction = widget.direction;
    switch (direction) {
      case Direction.vertical:
        return RotatedBox(
          quarterTurns: -1,
          child: bar,
        );
      case Direction.horizontal:
        return bar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBar();
  }
}
