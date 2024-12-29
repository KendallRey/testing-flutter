
import 'package:encrypt/encrypt.dart';

class AppEncryption {
  static final AppEncryption _appEncryption = AppEncryption._internal();

  late String? secret;
  late Encrypter encrypter;
  late IV iv;

  factory AppEncryption(String? _secret){
    if(_secret != null){
      final key = Key.fromUtf8(_secret.padRight(32, '*').substring(0, 32));
      _appEncryption.secret = _secret;
      _appEncryption.encrypter = Encrypter(AES(key));
      _appEncryption.iv = IV.fromLength(16);
    }
    return _appEncryption;
  }

  AppEncryption._internal(); 

  String encrypt(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(encryptedText), iv: iv);
    return decrypted;
  }
}