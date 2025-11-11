import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/main_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController emailAddController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  bool isLoadingOTP = false;
  bool otpSent = false;

  String decryptedResponse = "";
  String decryptedResponseII = "";

  Future<void> sendOtp() async {
    const url = "api/Account/AdminStaffOtpLogin";
    const completeURL = "$baseUrl$url";

    final Map<String, String> body = {
      "EmployeeId": '',
      "Password": '',
      "UserName": usernameController.text.toString(),
      "MobileNo": mobileController.text.toString(),
      "EmailAddress": emailAddController.text.trim(),
      "CompanyCode": '',
      "OTP": '',
      "EmployeeCode": '',
      "EmpCode": '',
      "Color1": '',
      "Color2": '',
      "Color3": '',
      "Color4": '',
      "payload": '',
    };

    // 🔹 Validate input fields
    if (body["EmailAddress"]!.isEmpty || body["MobileNo"]!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please enter both Email and Mobile No",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: AppTextTheme.primaryColor,
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(completeURL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("🌐 OTP Send Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final encryptedResponse = response.body.replaceAll('"', '');
        final decryptedText = AesEncryption.decryptAES(encryptedResponse);

        print("🔓 Decrypted OTP Response: $decryptedText");

        final decoded = jsonDecode(decryptedText);

        // 🟥 Case 1: API returned error
        if (decoded["Result"] == null && decoded["ErrorMessage"] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                decoded["ErrorMessage"],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              backgroundColor: AppTextTheme.primaryColor,
            ),
          );
          print("❌ OTP send failed: ${decoded["ErrorMessage"]}");
        }

        // 🟩 Case 2: OTP sent successfully
        if (decoded["Result"] != null) {
          setState(() {
            decryptedResponse = decryptedText;
            otpSent = true;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                // decoded["Result"].toString(),
                "OTP is Sent",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              backgroundColor: AppTextTheme.primaryColor,
            ),
          );

          print("✅ OTP Response: $decoded");
        } else {
          // 🟨 Unexpected case
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Unexpected response from server",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Server Error: ${response.statusCode}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            backgroundColor: AppTextTheme.primaryColor,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: AppTextTheme.primaryColor,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> verifyOtp() async {
    const url = "api/Account/AuthenticateUser";
    const completeURL = "$baseUrl$url";

    if (otpController.text.isEmpty || otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppTextTheme.primaryColor,
          content: Text(
            "Please enter a valid 6-digit OTP",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      );
      return;
    }

    final Map<String, dynamic> body = {
      "EmployeeId": 0,
      "Password": null,
      "UserName": usernameController.text.trim(),
      "MobileNo": mobileController.text.trim(),
      "EmailAddress": emailAddController.text.trim(),
      "CompanyCode": null,
      "OTP": otpController.text.trim(),
      "EmployeeCode": null,
      "EmpCode": null,
      "Color1": null,
      "Color2": null,
      "Color3": null,
      "Color4": null,
      "payload": null,
    };

    print("OTP Verify Payload: $body");

    setState(() => isLoadingOTP = true);

    try {
      final response = await http.post(
        Uri.parse(completeURL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("Verify OTP Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final encryptedResponse = response.body.replaceAll('"', '');
        final decryptedText = AesEncryption.decryptAES(encryptedResponse);

        print("🔓 Decrypted Response: $decryptedText");

        final decoded = jsonDecode(decryptedText);

        if (decoded["Result"] == null && decoded["ErrorMessage"] != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                decoded["ErrorMessage"],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              backgroundColor: AppTextTheme.primaryColor,
              behavior: SnackBarBehavior.floating, // allows positioning
              margin: EdgeInsets.only(
                top:
                    MediaQuery.of(context).padding.top + 10, // below status bar
                left: 16,
                right: 16,
              ),
              elevation: 6,
              duration: const Duration(seconds: 3),
            ),
          );
          print("Authentication failed: ${decoded["ErrorMessage"]}");
          return;
        }

        if (decoded["Result"] != null &&
            decoded["Result"]["Token"] != null &&
            decoded["Result"]["Token"].toString().isNotEmpty) {
          final token = decoded["Result"]["Token"];
          print("Login successful! Token: $token");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "${decoded["Result"]["user"]['Message']}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              backgroundColor: AppTextTheme.primaryColor,
              behavior: SnackBarBehavior.floating, // allows positioning
              margin: EdgeInsets.only(
                top:
                    MediaQuery.of(context).padding.top + 10, // below status bar
                left: 16,
                right: 16,
              ),
              elevation: 6,
              duration: const Duration(seconds: 3),
            ),
          );

          Get.off(() => MainScreen(), transition: Transition.rightToLeft);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                "Unexpected response from server",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Server Error: ${response.statusCode}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            backgroundColor: AppTextTheme.primaryColor,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error: $e",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: AppTextTheme.primaryColor,
        ),
      );
    } finally {
      if (mounted) setState(() => isLoadingOTP = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ADMIN LOGIN", style: AppTextTheme.subTitle),
                const SizedBox(height: 5),
                Text(
                  "Live Life. We've Got You Covered",
                  style: AppTextTheme.paragraph.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: usernameController,
                  hintText: "Username",
                  enabled: !otpSent,
                  readOnly: !otpSent ? false : true,
                ),

                CustomTextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailAddController,
                  hintText: "Email ID",
                  enabled: !otpSent,
                  readOnly: !otpSent ? false : true,
                ),

                CustomTextField(
                  controller: mobileController,
                  hintText: "Mobile No",
                  keyboardType: TextInputType.phone,
                  enabled: !otpSent,
                  readOnly: !otpSent ? false : true,
                ),
                const SizedBox(height: 10),

                otpSent
                    ? SizedBox()
                    : Buttons(
                        onPressed: isLoading ? null : sendOtp,
                        ddName: isLoading ? "PLEASE WAIT..." : "SEND OTP",
                        width: double.infinity,
                      ),

                if (otpSent) ...[
                  const SizedBox(height: 30),
                  Center(
                    child: Pinput(
                      controller: otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: PinTheme(
                        width: 48,
                        height: 56,
                        textStyle: TextStyle(
                          fontFamily: 'FontMain',
                          color: AppTextTheme.primaryColor,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppTextTheme.primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Buttons(
                    onPressed: isLoadingOTP ? null : verifyOtp,
                    ddName: isLoadingOTP ? "PLEASE WAIT..." : "VERIFY OTP",
                    width: double.infinity,
                  ),
                ],

                SizedBox(height: 60),

                Center(
                  child: Image.asset(
                    'assets/icons/asset_1.png',
                    width: 150,
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: TextButton(
                    onPressed: () => Get.off(
                      () => const LoginScreen(),
                      transition: Transition.rightToLeft,
                    ),
                    child: Text(
                      "Login as an Employee",
                      style: AppTextTheme.subItemTitle.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
