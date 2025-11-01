import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? textColor;

  Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.padding,
    this.fontSize,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ChiwiColors.MATCHA,
        padding: padding ?? .only(top: 15, bottom: 15, left: 50, right: 50),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? ChiwiColors.ALMOND,
          fontSize: fontSize ?? 28,
        ),
      ),
    );
  }
}
