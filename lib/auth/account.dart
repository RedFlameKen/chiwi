import 'package:chiwi/auth/user.dart';
import 'package:chiwi/encryption/encryptor.dart';
import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/requests/user_request_data.dart';
import 'package:chiwi/http/response.dart';

class AccountManager {

  static final INSTANCE = AccountManager();
  static const LOGIN_PATH = "/login";
  static const LOGOUT_PATH = "/logout";
  static const SIGNUP_PATH = "/signup";
  static const SIGNOUT_PATH = "/signout";

  User? user;

  AccountManager();

  Future<void> signup({
    required String username,
    required String password,
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
    }
  ) async {
    Encryptor encryptor = Encryptor();
    String saltIv = encryptor.getSaltIv();
    String encrypted = await encryptor.encrypt(password);

    String body = UserRequestData(
      username: username,
      password: encrypted,
      saltIv: saltIv,
    ).toJson();

    Response response = await HttpRequester.post(path: SIGNUP_PATH, body: body);

    if(response.status != 200){
      onFail!(
        "failed to signup! status code: ${response.status} message: ${response.message}"
      );
      return;
    }

    onSuccess!(response.message);
  }

  Future<void> signout({
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    if(user == null){
      onFail!("not logged in yet");
      return;
    }

    Map<String, String> headers = {
      "Authorization": "Bearer ${user!.auth_token}",
    };
    Response response = await HttpRequester.delete(
      path: SIGNOUT_PATH,
      headers: headers,
    );

    if(response.status != 200){
      onFail!(response.message);
      return;
    }
    user = null;
    onSuccess!(response.message);
  }

  Future<void> loginWithUsernameAndPassword({
    required String username,
    required String password,
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    Encryptor encryptor = Encryptor();
    String saltIv = encryptor.getSaltIv();
    String encrypted = await encryptor.encrypt(password);

    String body = UserRequestData(
      username: username,
      password: encrypted,
      saltIv: saltIv,
    ).toJson();


    Response response = await HttpRequester.post(path: LOGIN_PATH, body: body);
    if(response.status != 200){
      onFail!(response.message);
      return;
    }
    Map<String, dynamic> data = response.data;
    if(!data.containsKey("username") || !data.containsKey("auth_token")){
      onFail!(response.message);
      return;
    }
    user = User(username: data["username"], auth_token: data["auth_token"]);
    onSuccess!(response.message);
  }

  Future<void> logout({
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    if(user == null){
      onFail!("not logged in");
      return;
    }

    Map<String, String> headers = {
      "Authorization": "Bearer ${user!.auth_token}",
    };
    Response response = await HttpRequester.get(
      path: LOGOUT_PATH,
      headers: headers,
    );

    if(response.status != 200){
      onFail!(response.message);
      return;
    }
    user = null;
    onSuccess!(response.message);
  }

}
