import 'package:chiwi/reviewer/answer.dart';

enum FlashcardType { SIMPLE, MULTI_CHOICE, MULTI_ANSWER, ENUMERATION }

class Flashcard {
  double id;
  String? question;
  FlashcardType? type;
  DateTime? dateCreated;
  DateTime? dateModified;
  List<Answer> answers = List.empty(growable: true);

  Flashcard({
    required this.id,
    required this.question,
    required this.type,
    this.dateCreated,
    this.dateModified,
    this.answers = const [],
  });

}
