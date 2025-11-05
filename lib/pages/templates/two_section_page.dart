import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class TwoSectionPage extends StatelessWidget {
  final Widget leftChild;
  final Widget rightChild;
  final Color? leftColor;
  final Color? rightColor;

  const TwoSectionPage({
    super.key,
    required this.leftChild,
    required this.rightChild,
    this.leftColor,
    this.rightColor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ChiwiColors.ALMOND,
        child: Container(
          margin: EdgeInsets.all(15),
          color: ChiwiColors.SERENE_3,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: .infinity,
                  margin: EdgeInsets.all(15),
                  color: leftColor ?? ChiwiColors.ALMOND,
                  child: leftChild,
                ),
              ),
              Expanded(
                child: Container(
                  height: .infinity,
                  alignment: .bottomCenter,
                  margin: EdgeInsets.all(15),
                  color: rightColor ?? Colors.transparent,
                  child: rightChild
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
