import 'dart:convert';
import 'dart:typed_data';

import 'package:cryptography/cryptography.dart';

import 'encryption.dart';

class Encryptor extends Encryption {

  Encryptor();

  Future<String> encrypt(String data) async {
    await initKey();
    Cipher cipher = AesGcm.with256bits(nonceLength: Encryption.IV_LENGTH);
    Uint8List dataBytes = utf8.encode(data);

    SecretBox secretBox = await cipher.encrypt(
      dataBytes,
      secretKey: super.secretKey!,
      nonce: super.iv!,
    );

    Uint8List encrypted = secretBox.concatenation(nonce: false);
    return base64.encode(encrypted);
  }

  String getSaltIv(){
    String saltStr = base64.encode(salt!);
    String ivStr = base64.encode(iv!);
    return "$saltStr$ivStr";
  }
  
}
