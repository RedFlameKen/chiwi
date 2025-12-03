import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String description;

  ConfirmDialog({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisAlignment: .start,
        mainAxisSize: .min,
        children: [FittedBox(child: Text(description))],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
          },
          child: Text("CANCEL", style: TextStyle(color: ChiwiColors.MATCHA)),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          child: Text("YES", style: TextStyle(color: ChiwiColors.MATCHA)),
        ),
      ],
    );

  }
  
}
