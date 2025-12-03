import 'package:chiwi/enum/direction.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ProgressBarWidget extends StatelessWidget {
  final Direction direction;
  final double progress;
  final Duration duration;

  const ProgressBarWidget({
    super.key,
    required this.progress,
    this.direction = .horizontal,
    this.duration = const Duration(milliseconds: 500),
  });

  Widget createProgressIndicator() {
    return Expanded(
      child: TweenAnimationBuilder(
        tween: Tween(begin: 0, end: progress.clamp(0, 1)),
        duration: duration,
        builder: (context, value, widget) {
          return LinearProgressIndicator(
            borderRadius: BorderRadius.circular(5),
            minHeight: 30,
            value: value.toDouble(),
            backgroundColor: ChiwiColors.ALMOND,
            valueColor: AlwaysStoppedAnimation<Color>(ChiwiColors.PISTACHE),
          );
        },
      ),
    );
  }

  Widget buildBar() {
    Widget bar = createProgressIndicator();
    switch (direction) {
      case Direction.vertical:
        return RotatedBox(quarterTurns: -1, child: bar);
      case Direction.horizontal:
        return bar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildBar();
  }
}
