import 'dart:async';

import 'package:chiwi/components/chat/chat_component.dart';
import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/drawer/menu_drawer/menu_drawer.dart';
import 'package:chiwi/components/listener/listener_component.dart';
import 'package:chiwi/reviewer/flashcard.dart';
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
  void _onCommandSuccess(
    String? message,
    SetupCommandResponse result,
    StreamController<ChatData> chatStream,
  ) {
    chatStream.add(ChatData(message: result.transcribed, timeSent: .now()));
    chatStream.add(
      ChatData(message: result.message, timeSent: .now(), isMe: false),
    );
    debugPrint("received: ${result.message}");
    if (result.command == .LIST) {
      chatStream.add(
        ChatData<List<Flashcard>>(
          message: result.message,
          timeSent: .now(),
          isMe: false,
          data: result.data,
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
        Navigator.pop(context, true);
      });
      return;
    }
  }

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
                onSubmit: (input, chatStream) {
                  ReviewerSetupRequester.processCommandInput(
                    input: input,
                    onSuccess: (message, result) {
                      _onCommandSuccess(message, result, chatStream);
                    },
                  );
                },
                onListen: (recordingData, chatStream) {
                  ReviewerSetupRequester.processCommand(
                    recordingBytes: recordingData,
                    onSuccess: (message, result) {
                      _onCommandSuccess(message, result, chatStream);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Stack(
                alignment: .center,
                children: [
                  ChiwiWidget(),
                  Align(
                    alignment: .topRight,
                    child: Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openEndDrawer();
                          },
                          icon: Icon(Icons.menu, size: 50),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      endDrawer: MenuDrawer(
        exitDialogTitle: "Exit Setup",
        onExit: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
    );
  }
}
