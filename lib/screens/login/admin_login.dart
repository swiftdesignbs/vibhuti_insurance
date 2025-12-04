import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/otp_verify.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/main_screen.dart';
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

  String decryptedResponse = "";

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

    if (body["EmailAddress"]!.isEmpty || body["MobileNo"]!.isEmpty) {
      CustomToast.show(
        context: context,
        message: "Please enter both Email and Mobile No",
        success: false,
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

        //Test 1: API returned error (IsError is true)
        if (decoded["IsError"] == true) {
          CustomToast.show(
            context: context,
            message: decoded["ErrorMessage"] ?? "An error occurred",
            success: false,
          );
          print("❌ OTP send failed: ${decoded["ErrorMessage"]}");
          return; // Don't proceed further
        }

        // 🟩 Test 2: OTP sent successfully (IsError is false)
        if (decoded["IsError"] == false) {
          setState(() {
            decryptedResponse = decryptedText;
          });

          CustomToast.show(
            context: context,
            message: "OTP Sent Successfully!",
            success: true,
          );
          print("✅ OTP Response: $decoded");

          // Navigate to OTP verification screen
          navigateToVerifyScreen(decoded);
        } else {
          CustomToast.show(
            context: context,
            message: "Unexpected response from server",
            success: false,
          );
        }
      } else {
        CustomToast.show(
          context: context,
          message: "Server Error: ${response.statusCode}",
          success: false,
        );
      }
    } catch (e) {
      CustomToast.show(context: context, message: "Error: $e", success: false);
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void navigateToVerifyScreen(Map<String, dynamic> response) {
    // final employeeId = response["Result"]["employeeId"];
    final userName = usernameController.text;
    final mobileNo = mobileController.text;
    final email = emailAddController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminOtpVerifyScreen(
          //   employeeId: employeeId,
          userName: userName,
          mobileNo: mobileNo,
          email: email,
          //  encryptedData: decryptedResponse, // Pass the encrypted response if needed
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallDevice = screenSize.width < 370;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/icons/vib-logo-full-old.svg',
                fit: BoxFit.cover,
              ),
            ),

            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.arrowLeft,
                          color: Colors.grey,
                          size: 14,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Back",
                          style: AppTextTheme.subItemTitle.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("ADMIN LOGIN", style: AppTextTheme.subTitle),
                  const SizedBox(height: 20),

                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: usernameController,
                    hintText: "Username",
                  ),

                  CustomTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailAddController,
                    hintText: "Email ID",
                  ),

                  CustomTextField(
                    controller: mobileController,
                    hintText: "Mobile No",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),

                  Buttons(
                    onPressed: isLoading ? null : sendOtp,
                    ddName: isLoading ? "PLEASE WAIT..." : "SEND OTP",
                    width: double.infinity,
                  ),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
