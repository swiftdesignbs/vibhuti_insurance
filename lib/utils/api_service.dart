import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';

class ApiService {
  static Future<Map<String, dynamic>?> postRequest({
    required String url,
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );
      print("Payload : ${body}");
      if (response.statusCode != 200) {
        print("❌ Server Error: ${response.statusCode}");
        return null;
      }

      // 🔓 Remove extra quotes before decrypting
      final encrypted = response.body.replaceAll('"', '');

      // 🔓 AES Decrypt
      final decrypted = AesEncryption.decryptAES(encrypted);

      // Convert decrypted string to JSON
      final decoded = jsonDecode(decrypted);

      return decoded;
    } catch (e) {
      print("❌ API ERROR: $e");
      return null;
    }
  }
}
