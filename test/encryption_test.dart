
import 'package:chiwi/encryption/decryptor.dart';
import 'package:chiwi/encryption/encryptor.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testEncryption();
}

void testEncryption(){
  String message = "I choose you";
  String? saltIv;
  String? encrypted;
  test("test encryption utility", () async {
    Encryptor encryptor = Encryptor();
    saltIv = encryptor.getSaltIv();
    encrypted = await encryptor.encrypt(message);
  });
  test("test decryption utility", () async {
    Decryptor decryptor = Decryptor(saltIv!);
    String decrypted = await decryptor.decrypt(encrypted!);
    expect(decrypted, message);
  });
}
