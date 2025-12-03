import 'package:chiwi/auth/account.dart';
import 'package:chiwi/auth/user.dart';
import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/requests/create_reviewer_request_data.dart';
import 'package:chiwi/http/response.dart';
import 'package:chiwi/http/server_settings.dart';
import 'package:chiwi/reviewer/reviewer.dart';

class ReviewerRequester {
  static const CREATE_ENDPOINT = "/reviewer/create";
  static const LIST_ENDPOINT = "/reviewer/list";
  static const UPDATE_ENDPOINT = "/reviewer/update";
  static const DELETE_ENDPOINT = "/reviewer/delete";

  static Future<void> createReviewer({
    required String name,
    required String subject,
    required Function(String?) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, String> reviewerData = ReviewerRequestData(
      name: name,
      subject: subject,
    ).toMap();
    final response = await HttpRequester.post(
      path: CREATE_ENDPOINT,
      body: reviewerData,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );
    if (response.status != 200) {
      if (onFail != null) onFail(response.message!);
      return;
    }
    onSuccess(response.message!);
  }

  static Future<void> getReviewers({
    String? query,
    required Function(List<Reviewer>) onSuccess,
    Function(String?)? onFail,
  }) async {
    int id = _getUserId();
    if (id == -1) {
      if (onFail != null) {
        onFail("not logged in yet");
      }
      return;
    }

    Map<String, String>? params = null;
    if(query != null){
      params = {"query": query};
    }

    Response response = await HttpRequester.get(
      path: LIST_ENDPOINT,
      queryParams: params,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );
    if (response.status != 200) {
      if (onFail != null) onFail(response.message!);
      return;
    }
    List<dynamic> data = response.data;
    List<Reviewer> reviewers = List.generate(data.length, (i) {
      Map<String, dynamic> reviewerData = data[i];
      return Reviewer(
        id: reviewerData["id"],
        name: reviewerData["name"],
        subject: reviewerData["subject"],
        dateModified: DateTime.tryParse(reviewerData["date_modified"]),
        dateCreated: DateTime.tryParse(reviewerData["date_created"]),
        flashcardsCount: reviewerData["flashcards_count"],
      );
    });

    onSuccess(reviewers);
  }

  static Future<void> updateReviewer({
    required int id,
    required String name,
    required String subject,
    required Function(Reviewer) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, String> reviewerData = ReviewerRequestData(
      name: name,
      subject: subject,
    ).toMap();
    Response response = await HttpRequester.put(
      path: "$UPDATE_ENDPOINT/$id",
      body: reviewerData,
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );
    if (response.status != 200) {
      if (onFail != null) onFail(response.message!);
      return;
    }
    Map<String, dynamic> data = response.data;
    Reviewer reviewer = Reviewer(
      id: data["id"],
      name: data["name"],
      subject: data["subject"],
      dateModified: DateTime.tryParse(data["date_modified"]),
      dateCreated: DateTime.tryParse(data["date_created"]),
      flashcardsCount: data["flashcards_count"],
    );
    onSuccess(reviewer);
  }

  static Future<void> deleteReviewer({
    required int id,
    required Function(String?) onSuccess,
    Function(String?)? onFail,
  }) async {
    Response response = await HttpRequester.delete(
      path: "$DELETE_ENDPOINT/$id",
      port: ServerSettings.port,
      noPort: ServerSettings.port == -1,
      host: ServerSettings.host,
      https: ServerSettings.https,
    );
    if (response.status != 200) {
      if (onFail != null) onFail(response.message);
      return;
    }
    onSuccess(response.message);
  }

  static int _getUserId() {
    User? user = AccountManager.INSTANCE.user;
    return user != null ? user.id : -1;
  }
}
