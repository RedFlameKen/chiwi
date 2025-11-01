import 'package:chiwi/components/landing_page/voice_input_widgets.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class ReviwermakerPage extends StatelessWidget {
  const ReviwermakerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final half = screenWidth / 2;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: ChiwiColors.ALMOND),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              //this is the green widget
              width: half,
              color: ChiwiColors.MATCHA,
              child: Column(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: EdgeInsets.all(12),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: ChiwiColors.ALMOND,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          //text display
                          'this is to display the inputs and response',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      //tex input box
                      decoration: InputDecoration(
                        hintText: 'This is a test...',
                        filled: true,
                        fillColor: ChiwiColors.ALMOND,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VoiceInputWidgets(
              listenButton: () {
                //insert functions here
              }, 
              stopButton: () {
                //insert functions here
              }
            )
          ],
        ),
      ),
    );
  }
}
