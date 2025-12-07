import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppEncryption {
  static final AppEncryption _appEncryption = AppEncryption._internal();

  static late String secret;

  static Key getKeyFromSecret(String secret) =>
      Key.fromUtf8(secret.padRight(32, '*').substring(0, 32));

  static Encrypter getEncrypter(String secret) {
    final key = getKeyFromSecret(secret);
    final encrypter = Encrypter(AES(key));
    return encrypter;
  }

  static IV getIV() => IV.fromBase64(dotenv.env['ENCRYPTER_IV']!);

  factory AppEncryption(String secret) {
    secret = secret;
    return _appEncryption;
  }

  static void setKey(String secretKey) {
    secret = secretKey;
  }

  AppEncryption._internal();

  static String encrypt(String? plainText) {
    if (plainText == null || plainText.isEmpty) return '';
    final encrypter =
        Encrypter(AES(getKeyFromSecret(secret), mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: getIV());
    return encrypted.base64;
  }

  static String decrypt(String? encryptedText) {
    if (encryptedText == null || encryptedText.isEmpty) return '';
    try {
      final encrypter =
          Encrypter(AES(getKeyFromSecret(secret), mode: AESMode.cbc));
      final decrypted =
          encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: getIV());
      return decrypted;
    } catch (e) {
      return encryptedText;
    }
  }
}
