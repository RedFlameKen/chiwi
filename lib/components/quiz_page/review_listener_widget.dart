import 'package:flutter/material.dart';
import 'package:chiwi/style/colors.dart';

class ReviewListenerWidget extends StatefulWidget {
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

  List<String> quiz = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    loadQuiz();
  }

  void loadQuiz() {
    quiz = [question0, question1];
    setState(() {});
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
                  quiz[index],
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(8),
            child: Row(
              children: [
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ChiwiColors.VANILLA,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: loadQuestions,
                  child: Text("Next Question"),
                ),

                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ChiwiColors.VANILLA,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    answerRecorder();
                    checkAnswer();
                  },
                  child: Text("Record Answer"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
