import 'dart:async';

import 'package:chiwi/components/chat/chat_component.dart';
import 'package:chiwi/components/listener/listener_component.dart';
import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:chiwi/reviewer/review_command_type.dart';
import 'package:chiwi/reviewer/review_session_requester.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/components/stateless/loading_indicator_widget.dart';

class ReviewListenerWidget extends StatefulWidget {
  final ReviewSessionResponse initResponse;
  final int reviewerId;
  ReviewListenerWidget({required this.reviewerId, required this.initResponse});

  @override
  ReviewListenerWidgetState createState() => ReviewListenerWidgetState();
}

class ReviewListenerWidgetState extends State<ReviewListenerWidget> {
  int _curFlashcard = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  double _getQuizProgress() {
    return _curFlashcard / widget.initResponse.data!.flashcardCount;
  }

  void _onCommandSuccess(
    String? message,
    ReviewSessionResponse result,
    StreamController<ChatData> chatStream,
  ) {
    if (result.command == .FINISH) {
      chatStream.add(
        ChatData(message: "$message", timeSent: .now(), isMe: false),
      );
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
    setState(() {
      _isLoading = false;
    });
    if (result.command == ReviewCommandType.COMPLETE) {
      ReviewSessionRequester.finishReview(
        reviewerId: widget.reviewerId,
        onSuccess: (message, result) {
          setState(() {
            _curFlashcard++;
          });
        },
        onFail: (message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message ?? "unable to process command")),
          );
        },
      );
      return;
    }
    if (result.command == ReviewCommandType.MISUNDERSTOOD) {
      setState(() {
        chatStream.add(
          ChatData(message: "$message", timeSent: .now(), isMe: false),
        );
      });
      return;
    }
    String chatMessage = "";
    if (result.data != null) {
      switch (result.data!.state) {
        case QuizState.ASK_QUESTION:
          chatMessage = result.data!.question;
        case QuizState.LISTEN_FOR_ANSWER:
        case QuizState.CONFIRM_ANSWER:
          chatMessage = result.message;
      }
    } else
      chatMessage = result.message;
    setState(() {
      chatStream.add(
        ChatData(message: "$chatMessage", timeSent: .now(), isMe: false),
      );
      _curFlashcard = result.data!.curFlashcard;
    });
  }

  void _onCommandFailed(String? message) {
    _isLoading = false;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message ?? "unable to process command")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .max,
      children: [
        Expanded(
          child: Stack(
            children: [
              ListenerPanel(
                inputHint: "Enter Answers here...",
                onListen: (recordingData, streamController) {
                  ReviewSessionRequester.processCommand(
                    recordingBytes: recordingData,
                    onSuccess: (message, result) =>
                        _onCommandSuccess(message, result, streamController),
                    onFail: _onCommandFailed,
                  );
                },
                onInit: (streamController) {
                  streamController.add(
                    ChatData(
                      message: widget.initResponse.message,
                      timeSent: .now(),
                      isMe: false,
                    ),
                  );
                  streamController.add(
                    ChatData(
                      message: widget.initResponse.data!.question,
                      timeSent: .now(),
                      isMe: false,
                    ),
                  );
                },
              ),
              _isLoading ? LoadingIndicator() : Container(),
            ],
          ),
        ),
        ProgressBarWidget(direction: .vertical, progress: _getQuizProgress()),
      ],
    );
  }
}
