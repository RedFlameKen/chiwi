import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class ExitDialog extends StatelessWidget {
  final String title;
  const ExitDialog({super.key, this.title = "Exit"});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisAlignment: .start,
        mainAxisSize: .min,
        children: [FittedBox(child: Text("Are you sure you want to exit?"))],
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
