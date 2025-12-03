import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/dialog/exit_dialog.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  final Function() onExit;
  final String exitDialogTitle;

  const MenuDrawer({
    super.key,
    required this.onExit,
    this.exitDialogTitle = "Exit",
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: BeveledRectangleBorder(),
      backgroundColor: ChiwiColors.ALMOND,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: ChiwiColors.MATCHA,
              child: Padding(
                padding: .all(15),
                child: Column(
                  children: [
                    Flexible(child: ChiwiWidget()),
                    Text(
                      "CHIWI AI",
                      textAlign: .center,
                      style: TextStyle(fontSize: 42, color: ChiwiColors.ALMOND),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    shape: .all(BeveledRectangleBorder()),
                    padding: .all(.all(15)),
                  ),
                  icon: Transform.flip(
                    child: Icon(
                      Icons.logout,
                      color: ChiwiColors.MATCHA,
                      size: 28,
                    ),
                    flipX: true,
                  ),
                  label: Text(
                    "Exit",
                    style: TextStyle(fontSize: 36, color: ChiwiColors.MATCHA),
                  ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
