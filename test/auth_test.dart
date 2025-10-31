import 'dart:developer';

import 'package:chiwi/auth/account.dart';
import 'package:flutter_test/flutter_test.dart';

const String USERNAME = "TestUser";
const String PASSWORD = "testpassword1234";

void main(){
  testSignup();
  testLogout();
  testLogin();
  testSignout();
}

void testSignup(){
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

void testLogin(){
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

void testLogout(){
  test("Test Logout request", () async{
    await AccountManager.INSTANCE.loginWithUsernameAndPassword(
      username: USERNAME,
      password: PASSWORD, 
      onSuccess: (message) {
        log("logged in! message: ${message!}");
      }, 
      onFail: (message) {
        fail("failed to login! message: ${message!}");
      });
    await AccountManager.INSTANCE.logout(
      onSuccess: (message) {
        log("logged out! message: ${message!}");
      },
      onFail: (message) {
        fail("failed to logout! message: ${message!}");
      }
    );
    expect(AccountManager.INSTANCE.user, null);
  });
}

void testSignout(){
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
