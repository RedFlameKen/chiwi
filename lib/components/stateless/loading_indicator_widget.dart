import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:chiwi/style/colors.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: LoadingAnimationWidget.staggeredDotsWave(
          color: ChiwiColors.MATCHA,
          size: 200,
        ),
      );
  }
}