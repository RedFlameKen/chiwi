import 'dart:typed_data';

import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/recording/recording.dart';
import 'package:chiwi/reviewer/review_session_requester.dart';
import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ReviewListenerWidget extends StatefulWidget {
  final String initialQuestion;
  ReviewListenerWidget({required this.initialQuestion});

  @override
  ReviewListenerWidgetState createState() => ReviewListenerWidgetState();
}

class ReviewListenerWidgetState extends State<ReviewListenerWidget> {
  final String question0 = "Sino ang pumatay kay Lapu-Lapu?";
  final String question1 =
      "Rambo III was dedicated to this militant organization that went on to commit one of the most infamous terrorist attacks of the 21st century";

  final String answer0 = "Hindi ako sir";
  final String answer1 = "Al Qaeda";
  //temporary questions and answers for testing

  // FIXME: I know I said something about temporary code not being staged and commited, but this is a placeholder to get more features done
  String _displayQuestion = "";
  List<String> quiz = [];
  int index = 0;

  final Recorder recorder = Recorder();

  @override
  void initState() {
    super.initState();
    setState(() {
      _displayQuestion = widget.initialQuestion;
    });
    // loadQuiz();
  }

  void loadQuiz() {
    quiz = [question0, question1];
    setState(() {
      _displayQuestion = quiz[index];
    });
  }

  void loadQuestions() {
    for (index; index < quiz.length - 1; index++) {
      setState(() {});
    }
  }

  void answerRecorder() {
    //insert whisper code here
  }

  void checkAnswer() {
    //insert code for checking if the answer is correct here
  }

  void displayScore() {
    //yeah self explanatory
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ChiwiColors.MATCHA,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ChiwiColors.ALMOND,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  //question display
                  _displayQuestion,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Button(
                  onPressed: () async {
                    Uint8List recordingData = await recorder.startRecording();
                    setState(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("stopped"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    });
                    ReviewSessionRequester.processCommand(
                      recordingBytes: recordingData,
                      onSuccess: (message, result) {
                        String question = "";
                        if (result.data != null) {
                          result.data["question"] == null
                              ? "\n${result.data["question"]}"
                              : "";
                        }
                        setState(() {
                          _displayQuestion = "$message$question";
                        });
                      },
                      onFail: (message) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              message ?? "unable to process command",
                            ),
                          ),
                        );
                      },
                    );
                  },
                  text: "Record Answer",
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  backgroundColor: Colors.white,
                  textColor: ChiwiColors.CAROB,
                  fontSize: 14,
                ),
                Button(
                  onPressed: () async => await recorder.stopRecording(),
                  text: "Stop Recording",
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  backgroundColor: Colors.white,
                  textColor: ChiwiColors.CAROB,
                  fontSize: 14,
                ),
                Button(
                  onPressed: () {},
                  text: "Next Question",
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                  backgroundColor: Colors.white,
                  textColor: ChiwiColors.CAROB,
                  fontSize: 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
