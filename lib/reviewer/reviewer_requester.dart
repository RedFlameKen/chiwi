import 'package:chiwi/auth/account.dart';
import 'package:chiwi/auth/user.dart';
import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/requests/create_reviewer_request_data.dart';
import 'package:chiwi/http/response.dart';
import 'package:chiwi/reviewer/reviewer.dart';

class ReviewerRequester {
  static Future<void> getReviewers({
    required Function(List<Reviewer>) onSuccess,
    Function(String?)? onFail,
  }) async {
    int id = _getUserId();
    if (id == -1) {
      if(onFail != null){
        onFail("not logged in yet");
      }
      return;
    }

    Response response = await HttpRequester.get(path: "/reviewer/list", https: true,);
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
    if(response.status != 200){
      if(onFail != null)
        onFail(response.message!);
      return;
    }

    onSuccess(reviewers);
  }

  static Future<void> createReviewer({
    required String name,
    required String subject,
    required Function(String?) onSuccess,
    Function(String?)? onFail,
  }) async {
    Map<String, String> reviewerData = CreateReviewerRequestData(name: name, subject: subject).toMap();
    final response = await HttpRequester.post(path: "/reviewer/create", body: reviewerData, https: true);
    if(response.status != 200){
      if(onFail != null)
        onFail(response.message!);
      return;
    }
    onSuccess(response.message!);
  }

  static int _getUserId() {
    User? user = AccountManager.INSTANCE.user;
    return user != null ? user.id : -1;
  }
}
