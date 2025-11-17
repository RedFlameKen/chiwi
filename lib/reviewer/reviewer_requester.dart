import 'package:chiwi/auth/account.dart';
import 'package:chiwi/auth/user.dart';
import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/requests/create_reviewer_request_data.dart';
import 'package:chiwi/http/response.dart';
import 'package:chiwi/reviewer/reviewer.dart';

class ReviewerRequester {
  static Future<List<Reviewer>> getReviewers() async {
    int id = _getUserId();
    if (id == -1) {
      return List.empty();
    }

    Response response = await HttpRequester.get(path: "/reviewer/list", https: true);
    List<Map<String, dynamic>> data = response.data;
    List<Reviewer> reviewers = List.generate(data.length, (i) {
      Map<String, dynamic> reviewerData = data[i];
      return Reviewer(
        id: reviewerData["id"],
        name: reviewerData["name"],
        subject: reviewerData["subject"],
        dateModified: reviewerData["date_modified"],
        dateCreated: reviewerData["date_created"],
        flashcardsCount: reviewerData["flaschards_count"],
      );
    });

    return reviewers;
  }

  static Future<Response> createReviewer(String name, String subject) async {
    Map<String, String> reviewerData = CreateReviewerRequestData(name: name, subject: subject).toMap();
    return await HttpRequester.post(path: "/reviewer/create", body: reviewerData, https: true);
  }

  static int _getUserId() {
    User? user = AccountManager.INSTANCE.user;
    return user != null ? user.id : -1;
  }
}
