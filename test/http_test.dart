import 'dart:convert';

import 'package:chiwi/http/http_requester.dart';
import 'package:chiwi/http/response.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testGet();
  testPost();
}

void testGet(){
  test("test GET request utility", () async {
    Response response = await HttpRequester.get(path: "/test");
    expect(utf8.decode(response.data), "test mapping reached");
  });
}

void testPost(){
  test("test post request utility", () async {
    Map<String, dynamic> body = {
      "name": "kenneth",
      "age": "21"
    };
    Response response = await HttpRequester.post(path: "/test", body: body);
    expect(utf8.decode(response.data), "test mapping reached, data: {\"name\":\"kenneth\",\"age\":\"21\"}");
  });
}
