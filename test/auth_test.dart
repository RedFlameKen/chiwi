import 'dart:developer';

import 'package:chiwi/auth/account.dart';
import 'package:flutter_test/flutter_test.dart';

const String USERNAME = "TestUser";
const String PASSWORD = "testpassword1234";

void main()async{
  await testSignup();
  await testLogin();
  await testSignout();
}

Future<void> testSignup()async{
  test("Test Signup request", () async {
    await AccountManager.INSTANCE.signup(username: USERNAME, password: PASSWORD, 
      onSuccess: (message) {
        log("signed up! message: ${message!}");
      }, 
      onFail: (message) {
        fail("failed to sign up! message: ${message!}");
      });
  });
}

Future<void> testLogin()async{
  test("Test Login request", () async {
    await AccountManager.INSTANCE.loginWithUsernameAndPassword(
      username: USERNAME,
      password: PASSWORD, 
      onSuccess: (message) {
        log("logged in! message: ${message!}");
      }, 
      onFail: (message) {
        fail("failed to login! message: ${message!}");
      });
    expect(AccountManager.INSTANCE.user, isNotNull);
  });
}

Future<void> testSignout()async{
  test("Test Signout request", () async {
    await AccountManager.INSTANCE.signout(
      onSuccess: (message) {
        log("signed out! message: ${message!}");
      }, 
      onFail: (message) {
        fail("failed to sign out! message: ${message!}");
      });
    expect(AccountManager.INSTANCE.user, null);
  });
}
