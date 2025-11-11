import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;

class AesEncryption {
  static const String _key = "1njanrhdkCnsahrebfdMvbjo32hqnd31";
  static const String _iv = "jsKidmshatyb4jdu";

  static String decryptAES(String base64Encrypted) {
    try {
      final key = encrypt.Key.fromUtf8(_key);
      final iv = encrypt.IV.fromUtf8(_iv);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
      );

      final decrypted = encrypter.decrypt64(base64Encrypted, iv: iv);
      return decrypted;
    } catch (e) {
      return "Decryption Error: $e";
    }
  }

  static String encryptAES(String plainText) {
    try {
      final key = encrypt.Key.fromUtf8(_key);
      final iv = encrypt.IV.fromUtf8(_iv);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'),
      );

      final encrypted = encrypter.encrypt(plainText, iv: iv);
      return encrypted.base64;
    } catch (e) {
      return "Encryption Error: $e";
    }
  }
}
