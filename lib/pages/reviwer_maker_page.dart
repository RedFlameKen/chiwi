import 'dart:typed_data';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:chiwi/components/landing_page/voice_input_widgets.dart';
import 'package:chiwi/recording/recording.dart';
import 'package:chiwi/reviewer/reviewer_setup_requester.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class ReviewerMakerPage extends StatefulWidget {
  const ReviewerMakerPage({super.key});

  @override
  State<StatefulWidget> createState() => _ReviewerMakerPageState();

}

class _ReviewerMakerPageState extends State<ReviewerMakerPage> {

  String _displayMessage = "";
  final Recorder _recorder = Recorder();
  bool _loadAnimation = false;
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
                        child: Column(
                          children: [
                            Text(
                              //replace this with function to show inputs
                              //text display
                              '$_displayMessage',
                              style: TextStyle(fontSize: 20),
                            ),
                            _loadAnimation
                            ? LoadingAnimationWidget.staggeredDotsWave(color: ChiwiColors.MATCHA, size: 20)
                                :SizedBox.shrink(),
                          ],
                        )
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(8),
                    child: TextField(
                      //tex input box
                      decoration: InputDecoration(
                        hintText: 'Type Questions here..',
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
                  VoiceInputWidgets(
                    listenButton: () async {
                    Uint8List recordingData = await _recorder.startRecording();
                    setState(() {
                      _loadAnimation = true;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("stopped"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    });
                    ReviewerSetupRequester.processCommand(
                      recordingBytes: recordingData,
                      onSuccess: (message, result) {
                        setState(() {
                          _loadAnimation = false;
                          _displayMessage =
                              "command: ${result.command}\n${result.message}";
                        });
                        debugPrint("received: ${result.message}");
                      },
                    );

                    },
                    stopButton: () async => await _recorder.stopRecording(),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              //chiwi
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(5),
                child: Image.asset(
                  'lib/assets/chiwi3.png',
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}
