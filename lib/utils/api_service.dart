import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';

// class ApiService {
//   static Future<Map<String, dynamic>?> postRequest({
//     required String url,
//     required Map<String, dynamic> body,
//   }) async {
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode(body),
//       );
//       print("Payload : ${body}");
//       if (response.statusCode != 200) {
//         print("❌ Server Error: ${response.statusCode}");
//         return null;
//       }

//       // 🔓 Remove extra quotes before decrypting
//       final encrypted = response.body.replaceAll('"', '');

//       // 🔓 AES Decrypt
//       final decrypted = AesEncryption.decryptAES(encrypted);

//       // Convert decrypted string to JSON
//       final decoded = jsonDecode(decrypted);

//       return decoded;
//     } catch (e) {
//       print("❌ API ERROR: $e");
//       return null;
//     }
//   }
// }

class ApiService {
  static Future<Map<String, dynamic>?> postRequest({
    required String url,
    required Map<String, dynamic> body,
    required token, // 👈 Added optional token
  }) async {
    try {
      print("Calling: $url");
      print("Payload: ${jsonEncode(body)}");

      final headers = {"Content-Type": "application/json"};

      // 👇 Add Bearer Token only if provided
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(body),
      );

      print("Status: ${response.statusCode}");
      print("Raw Response: ${response.body}");

      if (response.statusCode != 200) {
        print("Server Error: ${response.statusCode}");
        return null;
      }

      // If encrypted inside quotes
      String encrypted = response.body;
      if (encrypted.startsWith('"') && encrypted.endsWith('"')) {
        encrypted = encrypted.substring(1, encrypted.length - 1);
      }

      final decrypted = AesEncryption.decryptAES(encrypted);
      return jsonDecode(decrypted) as Map<String, dynamic>;
    } catch (e) {
      print("API ERROR: $e");
      return null;
    }
  }
}
