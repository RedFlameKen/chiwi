import 'package:chiwi/components/chat/chat_component.dart';
import 'package:chiwi/components/listener/listener_component.dart';
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
                onListen: (recordingData, streamController) {
                  ReviewerSetupRequester.processCommand(
                    recordingBytes: recordingData,
                    onSuccess: (message, result) {
                      streamController.add(
                        ChatData(message: result.transcribed, timeSent: .now()),
                      );
                      streamController.add(
                        ChatData(
                          message: result.message,
                          timeSent: .now(),
                          isMe: false,
                        ),
                      );
                      debugPrint("received: ${result.message}");
                      if (result.command == SetupCommandType.FINISH_SETUP) {
                        streamController.add(
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
                child: Image.network('https://i.imgflip.com/77e8vi.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
