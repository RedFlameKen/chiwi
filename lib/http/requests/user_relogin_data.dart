import 'dart:convert';

class UserReloginData {

  String username;
  String auth_token;

  UserReloginData({required this.username, required this.auth_token});

  String toJson(){
    Map<String, Object> map = {
      "username": username,
      "auth_token": auth_token
    };

    return jsonEncode(map);
  }

}
