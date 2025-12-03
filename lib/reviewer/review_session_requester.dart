import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/server_settings.dart';
import 'package:chiwi/reviewer/answer.dart';
import 'package:chiwi/reviewer/flashcard_result.dart';
import 'package:chiwi/reviewer/review_command_type.dart';
import 'package:flutter/services.dart';

class ReviewSessionRequester {
  static const START_ENDPOINT = "/reviewer/review/start";
  static const COMMAND_ENDPOINT = "/reviewer/review/command";
  static const COMMAND_ENDPOINT_INPUT = "/reviewer/review/command/input";
  static const FINISH_ENDPOINT = "/reviewer/review/finish";

  static Future<void> startReview({
    required int reviewerId,
    required Function(String?, ReviewSessionResponse) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, int> body = {"reviewer_id": reviewerId};
    final response = await HttpRequester.post(
      path: START_ENDPOINT,
      body: body,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic> data = response.data;
    QuizResponse? quizResponse;

    if (data.containsKey("data")) {
      final quizData = data["data"];
      quizResponse = QuizResponse(
        question: quizData["question"],
        state: QuizState.values.byName(quizData["state"]),
        flashcardCount: quizData["flashcard_count"],
        curFlashcard: quizData["cur_flashcard"],
      );
    }
    final commandResponse = ReviewSessionResponse(
      message: data["message"],
      command: ReviewCommandType.values.byName(data["command"]),
      data: quizResponse,
    );

    onSuccess(response.message, commandResponse);
  }

  static Future<void> finishReview({
    required int reviewerId,
    required Function(String?, ReviewResultsResponse) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, int> body = {"reviewer_id": reviewerId};
    final response = await HttpRequester.post(
      path: FINISH_ENDPOINT,
      body: body,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic> data = response.data;
    final flashcards = response.data["flashcards"];
    final results = ReviewResultsResponse(
      message: data["message"],
      score: data["score"],
      total: data["total_items"],
      flashcards: _extractFlashcardResults(flashcards),
    );

    onSuccess(response.message, results);
  }

  static List<FlashcardResult> _extractFlashcardResults(List<dynamic> data) {
    return List.generate(data.length, (index) {
      final map = data[index];
      return FlashcardResult(
        question: map["question"],
        answerState: .values.byName(map["answer_state"]),
        answers: _extractAnswers(map["answers"]),
        submittedAnswer: map["submitted_answer"],
      );
    });
  }

  static List<Answer> _extractAnswers(List<dynamic> data) {
    return List.generate(data.length, (index) {
      return Answer(id: data[index]["id"], answer: data[index]["answer"]);
    });
  }

  static Future<void> processCommand({
    required Uint8List recordingBytes,
    required Function(String?, ReviewSessionResponse) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, Uint8List> files = {"audio": recordingBytes};
    final response = await HttpRequester.postForm(
      path: COMMAND_ENDPOINT,
      files: files,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic>? data = response.data;
    QuizResponse? quizResponse;
    ReviewSessionResponse commandResponse;

    if (data == null) {
      onFail!(response.message ?? "something went wrong");
      return;
    }

    if (data.containsKey("data")) {
      if (response.data["data"] != null) {
        final quizData = response.data["data"];
        quizResponse = QuizResponse(
          question: quizData["question"],
          state: QuizState.values.byName(quizData["state"]),
          flashcardCount: quizData["flashcard_count"],
          curFlashcard: quizData["cur_flashcard"],
        );
      }
    }
    commandResponse = ReviewSessionResponse(
      message: data["message"],
      command: ReviewCommandType.values.byName(data["command"]),
      data: quizResponse,
    );

    onSuccess(response.message, commandResponse);
  }

  static Future<void> processCommandInput({
    required String input,
    required Function(String?, ReviewSessionResponse) onSuccess,
    Function(String?)? onFail,
  }) async {
    final response = await HttpRequester.post(
      body: {"command": input},
      path: COMMAND_ENDPOINT_INPUT,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic>? data = response.data;
    QuizResponse? quizResponse;
    ReviewSessionResponse commandResponse;

    if (data == null) {
      onFail!(response.message ?? "something went wrong");
      return;
    }

    if (data.containsKey("data")) {
      if (response.data["data"] != null) {
        final quizData = response.data["data"];
        quizResponse = QuizResponse(
          question: quizData["question"],
          state: QuizState.values.byName(quizData["state"]),
          flashcardCount: quizData["flashcard_count"],
          curFlashcard: quizData["cur_flashcard"],
        );
      }
    }
    commandResponse = ReviewSessionResponse(
      message: data["message"],
      command: ReviewCommandType.values.byName(data["command"]),
      data: quizResponse,
    );

    onSuccess(response.message, commandResponse);
  }
}

enum QuizState { ASK_QUESTION, LISTEN_FOR_ANSWER, CONFIRM_ANSWER }

class ReviewSessionResponse<T> {
  final String message;
  final ReviewCommandType command;
  QuizResponse? data;

  ReviewSessionResponse({
    required this.message,
    required this.command,
    this.data,
  });
}

class QuizResponse {
  String question;
  QuizState state;
  int flashcardCount;
  int curFlashcard;

  QuizResponse({
    required this.question,
    required this.state,
    required this.flashcardCount,
    required this.curFlashcard,
  });
}

class ReviewResultsResponse {
  final String message;
  final int score;
  final int total;
  final List<FlashcardResult> flashcards;

  ReviewResultsResponse({
    required this.message,
    required this.score,
    required this.total,
    required this.flashcards,
  });
}
