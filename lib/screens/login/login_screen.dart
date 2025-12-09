import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/admin_login.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/main_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/otp_verification.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:http/http.dart' as http;
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController companyCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController employeeCodeController = TextEditingController();
  final controller = Get.put(StateController());

  bool showEmployeeCode = false;
  bool showMobileNo = false;
  bool showEmailId = false;
  bool isLoading = false;
  bool isCompanyCodeValidated = false;
  bool isFetchingConfig = false;

  Future<void> fetchLoginConfig() async {
    if (companyCodeController.text.trim().isEmpty) {
      CustomToast.show(
        context: context,
        message: "Please enter Company Code",
        success: false,
      );
      return;
    }

    setState(() => isFetchingConfig = true);

    const url = "${baseUrl}api/BCGModule/InsertAllLoginconfigData";
    final body = {
      "Action": "fetchloginconfig",
      "CorporateCode": companyCodeController.text.trim(),
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("Raw Response: ${response.body}");

      if (response.statusCode != 200) {
        CustomToast.show(
          context: context,
          message: "Server error: ${response.statusCode}",
          success: false,
        );
        resetConfig();
        return;
      }

      final encrypted = response.body.replaceAll('"', '');
      final decrypted = AesEncryption.decryptAES(encrypted);

      print("Decrypted: $decrypted");

      final decoded = jsonDecode(decrypted);

      // Case 1: API returns actual error
      if (decoded["IsError"] == true) {
        CustomToast.show(
          context: context,
          message: decoded["ErrorMessage"] ?? "Invalid Company Code",
          success: false,
        );
        resetConfig();
        return;
      }

      // Case 2: No config found
      final List configs = decoded["Result"]?["LoginconfigResponses"] ?? [];

      if (configs.isEmpty) {
        CustomToast.show(
          context: context,
          message: "Incorrect Company Code",
          success: false,
        );
        resetConfig();
        return;
      }

      // Case 3: Valid company code
      final config = configs.first;

      setState(() {
        isCompanyCodeValidated = true;
        showEmployeeCode = config["EmployeeCode"] == 1;
        showMobileNo = config["MobileNo"] == 1;
        showEmailId = config["EmailId"] == 1;
      });

      CustomToast.show(
        context: context,
        message: "Company code validated successfully!",
        success: true,
      );
    } catch (e) {
      CustomToast.show(
        context: context,
        message: "Network error: $e",
        success: false,
      );
      resetConfig();
    } finally {
      if (mounted) setState(() => isFetchingConfig = false);
    }
  }

  void resetConfig() {
    setState(() {
      isCompanyCodeValidated = false;
      showEmployeeCode = false;
      showMobileNo = false;
      showEmailId = false;
    });
  }

  Future<void> loginUser() async {
    if (!isCompanyCodeValidated) {
      CustomToast.show(
        context: context,
        message: "Please validate company code first",
        success: false,
      );
      return;
    }

    // Field Validations based on config visibility
    if (showEmployeeCode && employeeCodeController.text.trim().isEmpty) {
      CustomToast.show(
        context: context,
        message: "Enter Employee Code",
        success: false,
      );
      return;
    }
    if (showMobileNo && mobileController.text.trim().isEmpty) {
      CustomToast.show(
        context: context,
        message: "Enter Mobile Number",
        success: false,
      );
      return;
    }
    if (showEmailId && emailIdController.text.trim().isEmpty) {
      CustomToast.show(
        context: context,
        message: "Enter Email ID",
        success: false,
      );
      return;
    }

    setState(() => isLoading = true);

    const url = "${baseUrl}api/Account/Login";

    final body = {
      "EmployeeId": 0,
      "Password": null,
      "MobileNo": showMobileNo ? mobileController.text.trim() : "0",
      "EmailAddress": showEmailId ? emailIdController.text.trim() : "",
      "CompanyCode": companyCodeController.text.trim(),
      "OTP": null,
      "EmployeeCode": "",
      "EmpCode": showEmployeeCode ? employeeCodeController.text.trim() : "",
      "Color1": null,
      "Color2": null,
      "Color3": null,
      "Color4": null,
      "payload": null,
    };

    print("LOGIN REQUEST BODY: $body");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      print("RAW LOGIN RESPONSE: ${response.body}");

      if (response.statusCode != 200) {
        CustomToast.show(
          context: context,
          message: "Server error: ${response.statusCode}",
          success: false,
        );
        return;
      }

      // If your API returns encrypted text
      final encrypted = response.body.replaceAll('"', '');
      final decrypted = AesEncryption.decryptAES(encrypted);

      print("DECRYPTED LOGIN RESPONSE: $decrypted");

      final decoded = jsonDecode(decrypted);

      if (decoded["IsError"] == true) {
        CustomToast.show(
          context: context,
          message: decoded["ErrorMessage"] ?? "Login Failed",
          success: false,
        );
        return;
      }

      final user = decoded["Result"];
      print("User Data : $user");

      /// SAVE USER IN LOCAL STORAGE
      await controller.setAuthUser(user);

      /// SUCCESS
      CustomToast.show(
        context: context,
        message: "OTP Sent Successfully!",
        success: true,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OTPVerificationScreen(
            mobileNo: mobileController.text.trim(),
            email: emailIdController.text.trim(),
            companyCode: companyCodeController.text.trim(),
            empCode: employeeCodeController.text.trim(),
          ),
        ),
      );
    } catch (e) {
      CustomToast.show(
        context: context,
        message: "Network error: $e",
        success: false,
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
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
                  Text("Employee Login", style: AppTextTheme.pageTitle),
                  SizedBox(height: 20),

                  CustomTextFieldWithName(
                    keyboardType: TextInputType.text,
                    controller: companyCodeController,
                    hintText: "Company Code",
                    ddName: "Company Code",
                    readOnly: isCompanyCodeValidated,
                    enabled: !isCompanyCodeValidated,
                    onChanged: (value) {
                      final trimmedValue = value.trim();

                      // Minimum 4 characters, maximum 5 (or adjust as needed)
                      final hasMinimumLength = trimmedValue.length >= 4;
                      final isValidLength =
                          trimmedValue.length >= 4 && trimmedValue.length <= 5;

                      // Update controller with trimmed value
                      if (companyCodeController.text != trimmedValue) {
                        companyCodeController.value = TextEditingValue(
                          text: trimmedValue,
                          selection: TextSelection.collapsed(
                            offset: trimmedValue.length,
                          ),
                        );
                      }

                      // Trigger API when user has entered minimum required characters
                      if (hasMinimumLength && !isCompanyCodeValidated) {
                        fetchLoginConfig(); // Call your API here
                      } else if (trimmedValue.length < 4 &&
                          isCompanyCodeValidated) {
                        // Reset validation if length becomes less than minimum
                        setState(() {
                          isCompanyCodeValidated = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 5),
                  if (showEmployeeCode) ...[
                    CustomTextFieldWithName(
                      keyboardType: TextInputType.text,
                      controller: employeeCodeController,
                      hintText: "Employee Code *",
                      ddName: "Employee Code *",
                    ),
                  ],
                  SizedBox(height: 5),

                  if (showMobileNo) ...[
                    CustomTextFieldWithName(
                      keyboardType: TextInputType.phone,
                      controller: mobileController,
                      hintText: "Mobile No *",
                      ddName: "Mobile No *",
                    ),
                  ],
                  SizedBox(height: 5),

                  if (showEmailId) ...[
                    CustomTextFieldWithName(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailIdController,
                      hintText: "Email ID *",
                      ddName: "Email ID *",
                    ),
                  ],

                  SizedBox(height: 20),

                  if (isCompanyCodeValidated)
                    Buttons(
                      onPressed: isLoading ? null : loginUser,
                      ddName: isLoading ? "LOGGING IN..." : "LOGIN",
                      width: double.infinity,
                    ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
