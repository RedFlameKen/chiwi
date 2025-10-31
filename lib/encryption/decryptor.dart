import 'dart:convert';

import 'package:cryptography/cryptography.dart';

import 'encryption.dart';

class Decryptor extends Encryption {

  Decryptor(String saltIv)
    : super(
        salt: base64.decode(saltIv.substring(0, 24)),
        iv: base64.decode(saltIv.substring(24, 48)),
      );

  Future<String> decrypt(String data) async {
    await initKey();
    Cipher cipher = AesGcm.with256bits(nonceLength: Encryption.IV_LENGTH);
    List<int> decoded = List.from(iv!)..addAll(base64.decode(data));

    SecretBox secretBox = SecretBox.fromConcatenation(
      decoded,
      nonceLength: cipher.nonceLength,
      macLength: cipher.macAlgorithm.macLength,
    );

    List<int> deciphered = await cipher.decrypt(
      secretBox,
      secretKey: secretKey!,
    );

    return utf8.decode(deciphered);
  }
  
}
