import 'dart:math';

import 'package:cryptography/cryptography.dart';

class Encryption {

  static const ENCRYPTION_KEY = String.fromEnvironment("ENCRYPTION_KEY");
  static const PBKDF2_KEY_ITER = 65536;
  static const PBKDF2_KEY_LEN = 256;
  static const IV_LENGTH = 16;

  SecretKey? _secretKey;
  List<int>? _salt;
  List<int>? _iv;

  SecretKey? get secretKey => _secretKey;
  List<int>? get salt => _salt;
  List<int>? get iv => _iv;

  Encryption({List<int>? salt, List<int>? iv}){
    _salt = salt ?? generateBytes();
    _iv = iv ?? generateBytes();
  }

  Future<SecretKey> generateKey(String key, List<int> salt) async {
    var pbkdf2 = Pbkdf2.hmacSha256(iterations: PBKDF2_KEY_ITER, bits: PBKDF2_KEY_LEN);
    return pbkdf2.deriveKeyFromPassword(password: key, nonce: salt);
  }

  Future<void> initKey() async{
    _secretKey = await generateKey(ENCRYPTION_KEY, _salt!);
  }

  List<int> generateBytes({int length = 16}){
    final random = Random.secure();
    List<int> bytes = List.generate(length, (_) => random.nextInt(256));
    return bytes;
  }

}
