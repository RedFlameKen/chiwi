import 'package:chiwi/components/dialog/exit_dialog.dart';
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final Function() onExit;
  final String exitDialogTitle;

  const MenuDrawer({super.key, required this.onExit, this.exitDialogTitle = "Exit"});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ChiwiColors.ALMOND,
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: .all(15),
              child: Text("CHIWI AI", style: TextStyle(fontSize: 42)),
            ),
          ),
          SizedBox(),
          Button(
            onPressed: () async {
              final exit = await showDialog(
                context: context,
                builder: (context) {
                  return ExitDialog(title: exitDialogTitle);
                },
              );

              if (exit) {
                onExit();
              }
            },
            text: "Exit",
          ),
        ],
      ),
    );
  }
}
