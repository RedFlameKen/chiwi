import 'package:chiwi/components/chiwi/chiwi_widget.dart';
import 'package:chiwi/components/input/button.dart';
import 'package:chiwi/reviewer/answer.dart';
import 'package:chiwi/reviewer/answer_state.dart';
import 'package:chiwi/reviewer/flashcard_result.dart';
import 'package:chiwi/reviewer/review_session_requester.dart';
import 'package:chiwi/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

class QuizEndInfo extends StatelessWidget {
  final ReviewResultsResponse results;
  const QuizEndInfo({super.key, required this.results});

  Widget _buildAnswersPanel() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ChiwiColors.ALMOND,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListView.builder(
        itemCount: results.flashcards.length,
        itemBuilder: (context, index) {
          return _buildFlashcardResult(results.flashcards[index]);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _buildAnswersPanel()),
        Expanded(
          child: Column(
            //this is to display chiwi
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FittedBox(
                child: Text(
                  "${results.message}",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(),
              FittedBox(
                child: ChiwiWidget(assetPath: "lib/assets/chiwi1_updated.png"),
              ),
              Button(onPressed: (){
                Navigator.pop(context, true);
              }, text: "OK")
            ],
          ),
        ),
        Expanded(
          //this is the score display box
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ChiwiColors.ALMOND,
                    border: Border.all(color: ChiwiColors.MATCHA, width: 7),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "${results.score}/${results.total}",
                    style: const TextStyle(
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildFlashcardResult(FlashcardResult flashcard) {
  return Card(
    color: ChiwiColors.VANILLA,
    child: Padding(
      padding: .only(top: 5, bottom: 5, left: 15, right: 15),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            flashcard.question,
            style: TextStyle(
              fontWeight: .bold,
              color: ChiwiColors.MATCHA,
              fontSize: 14,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "correct answer: ",
                  style: TextStyle(color: ChiwiColors.CAROB, fontWeight: .bold),
                ),
                TextSpan(
                  text: "${flashcard.answers[0].answer}",
                  style: TextStyle(color: ChiwiColors.CAROB),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "your answer: ",
                  style: TextStyle(color: ChiwiColors.CAROB, fontWeight: .bold),
                ),
                TextSpan(
                  text: "${flashcard.submittedAnswer}",
                  style: TextStyle(color: ChiwiColors.CAROB),
                ),
                WidgetSpan(
                  child: _getIconForAnswerState(flashcard.answerState),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _getIconForAnswerState(AnswerState state) {
  switch (state) {
    case AnswerState.CORRECT:
      return Icon(Icons.check, color: Colors.lightGreen);
    case AnswerState.WRONG:
      return Icon(Icons.close, color: Colors.red);
    case AnswerState.UNANSWERED:
      return Container();
  }
}

@Preview(name: "FlashcardItem", group: "results")
Widget previewFlaschardItem() {
  List<FlashcardResult> flashcards = [
    FlashcardResult(
      question: "Sino pumatay Lapu-Lapu?",
      answerState: .CORRECT,
      answers: [Answer(id: 0, answer: "Hindi Ako")],
      submittedAnswer: "Hindi Ako",
    ),
    FlashcardResult(
      question: "What is 2+2?",
      answerState: .WRONG,
      answers: [Answer(id: 0, answer: "4")],
      submittedAnswer: "21",
    ),
  ];

  return ListView.builder(
    itemCount: flashcards.length,
    itemBuilder: (context, index) {
      return _buildFlashcardResult(flashcards[index]);
    },
  );
}
