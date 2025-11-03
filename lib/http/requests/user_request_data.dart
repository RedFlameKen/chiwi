import 'dart:convert';

class UserRequestData {
  String username;
  String password;

  UserRequestData({
    required this.username,
    required this.password
  });

  String toJson(){
    Map<String, Object> map = {
      "username": username,
      "password": password
    };

    return jsonEncode(map);
  }

}
