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

  void displayScore(){
    //yeah self explanatory
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //I can't for the life of me do frontend in flutter I'd rather be doing logic
      height: MediaQuery.of(context).size.height,
      width: 300,
      child: Column(
        children: [
          Text("B̶i̶g̶ ̶B̶r̶o̶t̶h̶e̶r̶  Chiwi is listening"),
          Container(height: 25),
          Text(quiz[index]),

          SizedBox(height: 20), //change buttons to match style of Chiwi
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ChiwiColors.MATCHA,
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
              backgroundColor: ChiwiColors.MATCHA,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: (){
              answerRecorder();
              checkAnswer();
            },
            child: Text("Record Answer"),
          ),
        ],
      ),
    );
  }
}
