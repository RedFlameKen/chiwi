import 'dart:async';

import 'package:chiwi/components/chat/chat_component.dart';
import 'package:chiwi/components/listener/listener_component.dart';
import 'package:chiwi/components/stateful/progress_bar_widget.dart';
import 'package:chiwi/pages/quiz_score_page.dart';
import 'package:chiwi/reviewer/review_command_type.dart';
import 'package:chiwi/reviewer/review_session_requester.dart';
import 'package:flutter/material.dart';

class ReviewListenerWidget extends StatefulWidget {
  final ReviewSessionResponse initResponse;
  final int reviewerId;
  ReviewListenerWidget({required this.reviewerId, required this.initResponse});

  @override
  ReviewListenerWidgetState createState() => ReviewListenerWidgetState();
}

class ReviewListenerWidgetState extends State<ReviewListenerWidget> {
  int _curFlashcard = 0;

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
    StreamController<ChatData> streamController,
  ) {
    if (result.command == ReviewCommandType.COMPLETE) {
      ReviewSessionRequester.finishReview(
        reviewerId: widget.reviewerId,
        onSuccess: (message, result) {
          setState(() {
            _curFlashcard++;
            // streamController.add(
            //   ChatData(
            //     message:
            //         "${result.message}\nYour score is ${result.score}/${result.total}",
            //     timeSent: .now(),
            //     isMe: false,
            //   ),
            // );
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => QuizScorePage(results: result),
            ),
          );
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
        streamController.add(
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
      streamController.add(
        ChatData(message: "$chatMessage", timeSent: .now(), isMe: false),
      );
      _curFlashcard = result.data!.curFlashcard;
    });
  }

  void _onCommandFailed(String? message) {
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
          child: ListenerPanel(
            inputHint: "Enter Answers here...",
            onSubmit: (input, chatStream) {
              ReviewSessionRequester.processCommandInput(
                input: input,
                onSuccess: (message, result) =>
                    _onCommandSuccess(message, result, chatStream),
                onFail: _onCommandFailed,
              );
            },
            onListen: (recordingData, chatStream) {
              ReviewSessionRequester.processCommand(
                recordingBytes: recordingData,
                onSuccess: (message, result) =>
                    _onCommandSuccess(message, result, chatStream),
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
        ),
        ProgressBarWidget(direction: .vertical, progress: _getQuizProgress()),
      ],
    );
  }
}
