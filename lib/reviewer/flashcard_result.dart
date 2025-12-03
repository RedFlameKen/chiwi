import 'package:chiwi/reviewer/answer.dart';
import 'package:chiwi/reviewer/answer_state.dart';

class FlashcardResult {
  String question;
  AnswerState answerState;
  List<Answer> answers;
  String submittedAnswer;

  FlashcardResult({
    required this.question,
    required this.answerState,
    required this.answers,
    required this.submittedAnswer
  });
}
