import 'dart:typed_data';

import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/response.dart';
import 'package:chiwi/reviewer/answer.dart';
import 'package:chiwi/reviewer/flashcard.dart';
import 'package:chiwi/reviewer/setup_command_type.dart';

class ReviewerSetupRequester {
  static const START_ENDPOINT = "/reviewer/setup/start";
  static const COMMAND_ENDPOINT = "/reviewer/setup/command";
  static const COMMAND_ENDPOINT_INPUT = "/reviewer/setup/command/input";

  static Future<void> startSetup({
    required int reviewerId,
    required Function(String?) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, int> body = {"reviewer_id": reviewerId};
    final response = await HttpRequester.post(
      path: START_ENDPOINT,
      body: body,
      https: true,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    onSuccess(response.message);
  }

  static Future<void> processCommandInput({
    required String input,
    required Function(String?, SetupCommandResponse) onSuccess,
    Function(String?)? onFail,
  }) async {
    Response response = await HttpRequester.post(
      body: {"command": input},
      path: COMMAND_ENDPOINT_INPUT,
      https: true,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic> data = response.data;
    var commandData;
    final command = SetupCommandType.values.byName(data["command"]);
    if (data.containsKey("data")) {
      commandData = command == .LIST
          ? _dataToFlashcardsList(data["data"])
          : data["data"];
    }
    final commandResponse = SetupCommandResponse(
      message: data["message"],
      command: command,
      transcribed: data["transcribed"],
      data: commandData,
    );
    onSuccess(response.message, commandResponse);
  }

  static Future<void> processCommand({
    required Uint8List recordingBytes,
    required Function(String?, SetupCommandResponse) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, Uint8List> files = {"audio": recordingBytes};
    Response response = await HttpRequester.postForm(
      path: COMMAND_ENDPOINT,
      https: true,
      files: files,
    );

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    Map<String, dynamic> data = response.data;
    var commandData;
    final command = SetupCommandType.values.byName(data["command"]);
    if (data.containsKey("data")) {
      commandData = command == .LIST
          ? _dataToFlashcardsList(data["data"])
          : data["data"];
    }
    final commandResponse = SetupCommandResponse(
      message: data["message"],
      command: command,
      transcribed: data["transcribed"],
      data: commandData,
    );
    onSuccess(response.message, commandResponse);
  }
}

List<Flashcard> _dataToFlashcardsList(List<dynamic> data) {
  return List.generate(data.length, (index) {
    final map = data[index];
    return Flashcard(
      id: map["flashcard_id"],
      question: map["question"],
      type: FlashcardType.values.byName(map["flashcard_type"]),
      dateCreated: DateTime.parse(map["date_created"]),
      dateModified: DateTime.parse(map["date_modified"]),
      answers: _dataToAnswersList(map["answers"]),
    );
  });
}

List<Answer> _dataToAnswersList(List<dynamic> data) {
  return List.generate(data.length, (index) {
    return Answer(id: data[index]["id"], answer: data[index]["answer"]);
  });
}

class SetupCommandResponse<T> {
  final SetupCommandType command;
  final String message;
  final String transcribed;
  T? data;

  SetupCommandResponse({
    required this.message,
    required this.command,
    required this.transcribed,
    this.data,
  });
}
