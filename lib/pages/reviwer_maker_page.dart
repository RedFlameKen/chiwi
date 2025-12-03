import 'package:chiwi/components/chat/chat_component.dart';
import 'package:chiwi/components/listener/listener_component.dart';
import 'package:chiwi/reviewer/flashcard.dart';
import 'dart:typed_data';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:chiwi/components/landing_page/voice_input_widgets.dart';
import 'package:chiwi/recording/recording.dart';
import 'package:chiwi/reviewer/reviewer_setup_requester.dart';
import 'package:chiwi/reviewer/setup_command_type.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';

class ReviewerMakerPage extends StatefulWidget {
  const ReviewerMakerPage({super.key});

  @override
  State<StatefulWidget> createState() => _ReviewerMakerPageState();

}

class _ReviewerMakerPageState extends State<ReviewerMakerPage> {

  String _displayMessage = "";
  bool _loadAnimation = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: ChiwiColors.ALMOND),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListenerPanel(
                onListen: (recordingData, chatStream) {
                  ReviewerSetupRequester.processCommand(
                    recordingBytes: recordingData,
                    onSuccess: (message, result) {
                      chatStream.add(
                        ChatData(message: result.transcribed, timeSent: .now()),
                      );
                      chatStream.add(
                        ChatData(
                          message: result.message,
                          timeSent: .now(),
                          isMe: false,
                        ),
                      );
                      debugPrint("received: ${result.message}");
                      if (result.command == .LIST) {
                        chatStream.add(
                          ChatData<List<Flashcard>>(
                            message: result.message,
                            timeSent: .now(),
                            isMe: false,
                            data: result.data
                          ),
                        );
                        return;
                      }
                      if (result.command == SetupCommandType.FINISH_SETUP) {
                        chatStream.add(
                          ChatData(
                            message: "Closing this page now...",
                            timeSent: .now(),
                            isMe: false,
                          ),
                        );
                        Future.delayed(Duration(seconds: 3), () {
                          Navigator.pop(context);
                        });
                        return;
                      }
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5),
                child: Image.asset(
                  'lib/assets/chiwi3.png',
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// _loadAnimation
// ? LoadingAnimationWidget.staggeredDotsWave(color: ChiwiColors.MATCHA, size: 20)
//     :SizedBox.shrink(),
