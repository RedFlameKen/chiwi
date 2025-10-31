
import 'package:chiwi/encryption/decryptor.dart';
import 'package:chiwi/encryption/encryptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testEncryption();
}

void testEncryption(){
  String message = "I choose you";
  List<int>? iv;
  List<int>? salt;
  String? encrypted;
  test("test encryption utility", () async {
    Encryptor encryptor = Encryptor();
    salt = encryptor.salt!;
    iv = encryptor.iv!;
    encrypted = await encryptor.encrypt(message);
  });
  test("test decryption utility", () async {
    Decryptor decryptor = Decryptor(salt: salt, iv: iv);
    String decrypted = await decryptor.decrypt(encrypted!);
    expect(decrypted, message);
  });
}
