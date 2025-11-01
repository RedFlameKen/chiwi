import 'dart:convert';

class UserRequestData {
  String username;
  String password;
  String saltIv;

  UserRequestData({
    required this.username,
    required this.password,
    required this.saltIv,
  });

  String toJson(){
    Map<String, Object> map = {
      "username": username,
      "password": password,
      "salt_iv": saltIv
    };

    return jsonEncode(map);
  }

}
