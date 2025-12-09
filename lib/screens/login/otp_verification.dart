import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/admin_dashboard.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/employee_module/employee_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/main_screen.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String mobileNo;
  final String email;
  final String companyCode;
  final String empCode;

  const OTPVerificationScreen({
    super.key,
    required this.mobileNo,
    required this.email,
    required this.companyCode,
    required this.empCode,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  final controller = Get.put(StateController());
  bool isLoadingOTP = false;

  Future<void> verifyOtp() async {
    const url = "api/Account/Verify";
    const completeURL = "$baseUrl$url";
    // Validate OTP
    if (otpController.text.isEmpty || otpController.text.length != 6) {
      CustomToast.show(
        context: context,
        message: "Please enter a valid 6-digit OTP",
        success: false,
      );
      return;
    }
    final Map<String, dynamic> body = {
      "EmployeeId": 0,
      "Password": null,
      "UserName": null,
      "MobileNo": widget.mobileNo,
      "EmailAddress": widget.email,
      "CompanyCode": widget.companyCode,
      "OTP": otpController.text.trim(),
      "EmployeeCode": "",
      "EmpCode": widget.empCode,
      "Color1": null,
      "Color2": null,
      "Color3": null,
      "Color4": null,
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

        if (decoded["IsError"] == true) {
          CustomToast.show(
            context: context,
            message: decoded["ErrorMessage"] ?? "Authentication failed",
            success: false,
          );
          print("Authentication failed: ${decoded["ErrorMessage"]}");
          return;
        }
        // 🟩 Check for successful authentication (IsError is false)
        if (decoded["IsError"] == false &&
            decoded["Result"] != null &&
            decoded["Result"]["accessToken"] != null &&
            decoded["Result"]["accessToken"].toString().isNotEmpty) {
          print("decoded Response: $decoded");

          final tokenData = decoded["Result"]["accessToken"];
          final message = decoded["ErrorMessage"] ?? "Login successful";
          print("✅ Login successful! Token: $tokenData");
          // Store token
          await controller.setAuthToken(tokenData);
          CustomToast.show(context: context, message: message, success: true);
          await fetchUserProfile();
        } else {
          CustomToast.show(
            context: context,
            message: "Invalid response from server",
            success: false,
          );
          print("Unexpected response structure: $decoded");
        }
      } else {
        print("Server Error: ${response.statusCode}");
        CustomToast.show(
          context: context,
          message: "Server Error: ${response.statusCode}",
          success: false,
        );
      }
    } catch (e) {
      print("Network Error: $e");
      CustomToast.show(
        context: context,
        message: "Network Error: $e",
        success: false,
      );
      print("Exception during OTP verification: $e");
    } finally {
      if (mounted) setState(() => isLoadingOTP = false);
    }
  }

  Timer? _timer;
  int _resendTimer = 60;
  bool _canResend = false;

  void _startTimer() {
    _timer?.cancel(); // cancel old timer before starting new one
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _canResend = true;
          timer.cancel();
        }
      });
    });
  }

  void _resendOtp() {
    if (_canResend) {
      print("Resending OTP...");

      setState(() {
        _resendTimer = 60;
        _canResend = false;
      });

      _startTimer();
      CustomToast.show(
        context: context,
        message: "OTP resent successfully!",
        success: true,
      );
    }
  }

  //here cal the API to user profile display

  // ------------------------------------------------------
  // USER PROFILE DISPLAY API (With Double AES Decryption)
  // ------------------------------------------------------
  Future<void> fetchUserProfile() async {
    const url = "api/Account/userprofile_display";
    const completeURL = "$baseUrl$url";

    final Map<String, dynamic> body = {
      "EmployeeId": controller.authUser["employeeId"] ?? 0,
      "Password": null,
      "UserName": null,
      "MobileNo": widget.mobileNo,
      "EmailAddress": widget.email,
      "CompanyCode": widget.companyCode,
      "OTP": otpController.text.trim(),
      "EmployeeCode": "",
      "EmpCode": widget.empCode,
      "Color1": null,
      "Color2": null,
      "Color3": null,
      "Color4": null,
    };

    print("📩 User Profile Payload: $body");

    try {
      final response = await http.post(
        Uri.parse(completeURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${controller.authToken.value}",
        },
        body: jsonEncode(body),
      );

      print("📥 Raw Encrypted Response (Level 1): ${response.body}");

      if (response.statusCode != 200) {
        CustomToast.show(
          context: context,
          message: "Server Error: ${response.statusCode}",
          success: false,
        );
        return;
      }

      // 🔐 FIRST DECRYPT
      final level1 = AesEncryption.decryptAES(
        response.body.replaceAll('"', ''),
      );

      print("🔓 Level 1 Decrypted: $level1");

      // 🧹 FIX: remove surrounding quotes from level1!
      final cleanedLevel1 = level1.replaceAll('"', '').trim();

      // 🔐 SECOND DECRYPT
      final level2 = AesEncryption.decryptAES(cleanedLevel1);
      print("🔓 Level 2 Decrypted (Final JSON): $level2");

      final profileData = jsonDecode(level2);

      if (profileData["IsError"] == true) {
        CustomToast.show(
          context: context,
          message: profileData["ErrorMessage"] ?? "Failed to load user profile",
          success: false,
        );
        return;
      }
      final userData = profileData["Result"]["userData"];
      print("🎯 Final User Data: $userData");

      controller.setAuthUserProfileData(userData);
      // Navigate to Employee screen
      Get.offAll(() => MainScreen(), transition: Transition.rightToLeft);
    } catch (e) {
      print("❌ User Profile Error: $e");
      CustomToast.show(
        context: context,
        message: "User Profile Error: $e",
        success: false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    print("Print previous screen data");
    print(widget.mobileNo);
    print(widget.email);
    print(widget.companyCode);
    print(widget.empCode);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallDevice = screenSize.width < 370;
    return Scaffold(
      backgroundColor: Colors.white,
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
                  Text("OTP Verification", style: AppTextTheme.subTitle),
                  const SizedBox(height: 10),

                  // Instruction text
                  Text(
                    "Enter the 6-digit OTP sent to ${widget.mobileNo}",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),

                  // OTP Input
                  Center(
                    child: Pinput(
                      controller: otpController,
                      length: 6,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: TextStyle(
                          fontFamily: 'FontMain',
                          color: AppTextTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppTextTheme.primaryColor),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: TextStyle(
                          fontFamily: 'FontMain',
                          color: AppTextTheme.primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: AppTextTheme.primaryColor,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppTextTheme.primaryColor.withOpacity(0.1),
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      submittedPinTheme: PinTheme(
                        width: 50,
                        height: 50,
                        textStyle: TextStyle(
                          fontFamily: 'FontMain',
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: BoxDecoration(
                          color: AppTextTheme.primaryColor,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: AppTextTheme.primaryColor),
                        ),
                      ),
                      onCompleted: (pin) {
                        verifyOtp();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _canResend ? '' : 'Resend in $_resendTimer s',
                        style: AppTextTheme.paragraph.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: _canResend ? _resendOtp : null,
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: _canResend
                                ? AppTextTheme.primaryColor
                                : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Buttons(
                    onPressed: isLoadingOTP ? null : verifyOtp,
                    ddName: isLoadingOTP ? "VERIFYING..." : "Submit",
                    width: double.infinity,
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
