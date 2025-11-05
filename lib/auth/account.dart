import 'package:chiwi/auth/user.dart';
import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/requests/user_relogin_data.dart';
import 'package:chiwi/http/requests/user_request_data.dart';
import 'package:chiwi/http/response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountManager {
  static final INSTANCE = AccountManager();
  static const LOGIN_PATH = "/login";
  static const RELOGIN_PATH = "/login/auth";
  static const LOGOUT_PATH = "/logout";
  static const SIGNUP_PATH = "/signup";
  static const SIGNOUT_PATH = "/signout";

  static const BACKEND_SERVER_HOST = "localhost";
  static const USE_HTTPS = true;
  static const HOST_HAS_PORT = true;

  final storage = FlutterSecureStorage();

  User? user;

  AccountManager();

  Future<void> initUser() async {
    String? username = await storage.read(key: "username");
    String? auth_token = await storage.read(key: "auth_token");
    if (username == null || auth_token == null) {
      user = null;
      return;
    }
    user = User(username: username, auth_token: auth_token);
  }

  Future<void> signup({
    required String username,
    required String password,
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    String body = UserRequestData(
      username: username,
      password: password,
    ).toJson();

    Response response;
    try {
      response = await HttpRequester.post(
        https: USE_HTTPS,
        host: BACKEND_SERVER_HOST,
        noPort: !HOST_HAS_PORT,
        path: SIGNUP_PATH,
        body: body,
      );
    } catch (e) {
      onFail!("connection failed! $e");
      return;
    }

    if (response.status != 200) {
      onFail!("${response.message}");
      return;
    }
    onSuccess!(response.message);
  }

  Future<void> signout({
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    if (user == null) {
      onFail!("not logged in yet");
      return;
    }

    Map<String, String> headers = {
      "Authorization": "Bearer ${user!.auth_token}",
    };
    Response response;
    try {
      response = await HttpRequester.delete(
        https: USE_HTTPS,
        host: BACKEND_SERVER_HOST,
        noPort: !HOST_HAS_PORT,
        path: SIGNOUT_PATH,
        headers: headers,
      );
    } catch (e) {
      onFail!("connection failed! $e");
      return;
    }

    if (response.status != 200) {
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
    String body = UserRequestData(
      username: username,
      password: password,
    ).toJson();

    Response response;
    try {
      response = await HttpRequester.post(
        https: USE_HTTPS,
        host: BACKEND_SERVER_HOST,
        noPort: !HOST_HAS_PORT,
        path: LOGIN_PATH,
        body: body,
      );
    } catch (e) {
      onFail!("connection failed! $e");
      return;
    }

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }
    Map<String, dynamic> data = response.data;
    if (!data.containsKey("username") || !data.containsKey("auth_token")) {
      onFail!(response.message);
      return;
    }

    user = User(username: data["username"], auth_token: data["auth_token"]);
    await storage.write(key: "username", value: user!.username);
    await storage.write(key: "auth_token", value: user!.auth_token);
    onSuccess!(response.message);
  }

  Future<void> loginWithAuthToken({
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    if (user == null) {
      onFail!("user not initialized");
      return;
    }

    String body = UserReloginData(
      username: user!.username,
      auth_token: user!.auth_token,
    ).toJson();
    print("username: ${user!.username}, token: ${user!.auth_token}");

    Response response;
    try {
      response = await HttpRequester.post(
        https: USE_HTTPS,
        host: BACKEND_SERVER_HOST,
        noPort: !HOST_HAS_PORT,
        path: RELOGIN_PATH,
        body: body,
      );
    } catch (e) {
      onFail!("connection failed! $e");
      return;
    }

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }
    Map<String, dynamic> data = response.data;
    if (!data.containsKey("username") || !data.containsKey("auth_token")) {
      onFail!(response.message);
      return;
    }
    user = User(username: data["username"], auth_token: data["auth_token"]);
    await storage.write(key: "username", value: user!.username);
    await storage.write(key: "auth_token", value: user!.auth_token);
    onSuccess!(response.message);
  }

  Future<void> logout({
    Function(String? message)? onSuccess,
    Function(String? message)? onFail,
  }) async {
    if (user == null) {
      onFail!("not logged in");
      return;
    }

    Map<String, String> headers = {
      "Authorization": "Bearer ${user!.auth_token}",
    };

    Response response;
    try {
      response = await HttpRequester.get(
        https: USE_HTTPS,
        host: BACKEND_SERVER_HOST,
        noPort: !HOST_HAS_PORT,
        path: LOGOUT_PATH,
        headers: headers,
      );
    } catch (e) {
      onFail!("connection failed! $e");
      return;
    }

    if (response.status != 200) {
      onFail!(response.message);
      return;
    }
    user = null;
    onSuccess!(response.message);
  }
}
