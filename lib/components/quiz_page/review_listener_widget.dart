import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ReviewListenerWidget extends StatefulWidget {
  @override
  ReviewListenerWidgetState createState() => ReviewListenerWidgetState();
}

class ReviewListenerWidgetState extends State<ReviewListenerWidget> {
  String question = "";

  void loadQuestion() {
    //insert code for fetching questions here
  }

  void answerRecorder() {
    //insert whisper code here
  }

  void checkAnswer() {
    //insert code for checking if the answer is correct here. If we plan to add animations it should also be here
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //I can't for the life of me do frontend in flutter I'd rather be doing logic
      height: MediaQuery.of(context).size.height,
      width: 300,
      child: Column(
        children: [
          Text("B̶i̶g̶ ̶B̶r̶o̶t̶h̶e̶r̶  Chiwi is listening")
        ],
      ),
    );
  }
}
