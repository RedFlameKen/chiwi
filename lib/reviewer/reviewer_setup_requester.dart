import 'dart:typed_data';

import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/response.dart';
import 'package:chiwi/reviewer/setup_command_type.dart';

class ReviewerSetupRequester {
  static const START_ENDPOINT = "/reviewer/setup/start";
  static const COMMAND_ENDPOINT = "/reviewer/setup/command";

  static Future<void> startSetup({
    required int reviewerId,
    required Function(String?) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, int> body = {"reviewer_id": reviewerId};
    final response = await HttpRequester.post(path: START_ENDPOINT, body: body, https: true);

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }

    onSuccess(response.message);
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
    if(data.containsKey("data")){
      commandData = data["data"];
    }
    final commandResponse = SetupCommandResponse(
      message: data["message"],
      command: SetupCommandType.values.byName(data["command"]),
      data: commandData
    );
    onSuccess(response.message, commandResponse);

  }
}

class SetupCommandResponse<T> {
  final SetupCommandType command;
  final String message;
  T? data;

  SetupCommandResponse({
    required this.message,
    required this.command,
    this.data,
  });
}
