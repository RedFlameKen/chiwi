import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/reviewer/review_command_type.dart';
import 'package:flutter/services.dart';

class ReviewSessionRequester {
  static const START_ENDPOINT = "/reviewer/review/start";
  static const COMMAND_ENDPOINT = "/reviewer/review/command";

  static Future<void> startReview({
    required int reviewerId,
    required Function(String?, QuizResponse) onSuccess,
    Function(String?)? onFail
  }) async {
    Map<String, int> body = {"reviewer_id": reviewerId};
    final response = await HttpRequester.post(path: START_ENDPOINT, body: body, https: true);

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic> data = response.data;
    var commandData;
    if(data.containsKey("data")){
      commandData = data["data"];
    }
    final commandResponse = QuizResponse(
      message: data["message"],
      command: ReviewCommandType.values.byName(data["command"]),
      data: commandData
    );

    onSuccess(response.message, commandResponse);
  }

  static Future<void> processCommand({
    required Uint8List recordingBytes,
    required Function(String?, QuizResponse) onSuccess,
    Function(String?)? onFail
  }) async {
    Map<String, Uint8List> files = {"audio": recordingBytes};
    final response = await HttpRequester.postForm(
      path: COMMAND_ENDPOINT,
      https: true,
      files: files,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic>? data = response.data;
    Map<String, dynamic>? commandData;
    QuizResponse commandResponse;

    if(data == null){
      onFail!(response.message ?? "something went wrong");
      return;
    }

    if(data.containsKey("data")){
      commandData = response.data["data"];
    }
    commandResponse = QuizResponse(
        message: data["message"],
        command: ReviewCommandType.values.byName(data["command"]),
        data: commandData
        );

    onSuccess(response.message, commandResponse);
  }
  
}

class QuizResponse<T> {
  String message;
  ReviewCommandType command;
  T? data;

  QuizResponse({
    required this.message,
    required this.command,
    this.data
  });
}
