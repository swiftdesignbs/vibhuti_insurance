import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/admin_login.dart';
import 'package:vibhuti_insurance_mobile_app/screens/main_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
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
  String decryptedResponse = "";

  @override
  void initState() {
    super.initState();
    fetchLoginConfig();
  }

  Future<void> fetchLoginConfig() async {
    const url = "api/BCGModule/InsertAllLoginconfigData";

    final body = {"Action": "fetchloginconfig", "CorporateCode": "HOH"};
    const completeURL = "${baseUrl}api/BCGModule/InsertAllLoginconfigData";
    print(completeURL);
    try {
      final response = await http.post(
        Uri.parse(completeURL),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final encryptedResponse = response.body.replaceAll('"', '');
        final decryptedText = AesEncryption.decryptAES(encryptedResponse);
        setState(() {
          decryptedResponse = decryptedText;
        });
        print("decryptedResponse : ${decryptedResponse}");
      } else {
        if (!mounted) return;

        setState(() {
          decryptedResponse = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        decryptedResponse = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("EMPLOYEE LOGIN", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              Text(
                "Live Life. We've Got You Covered",
                style: AppTextTheme.paragraph.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                keyboardType: TextInputType.text,
                controller: companyCodeController,
                hintText: "Company Code",
              ),
              CustomTextField(
                keyboardType: TextInputType.phone,
                controller: mobileController,
                hintText: "Mobile No",
              ),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailIdController,
                hintText: "Email ID",
              ),

              SizedBox(height: 20),

              Buttons(
                onPressed: () {
                  Get.off(
                    () => MainScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
                ddName: "LOG IN",
                width: double.infinity,
              ),
              Spacer(),
              Center(
                child: Image.asset(
                  'assets/icons/asset_1.png',
                  width: 150,
                  height: 150,
                ),
              ),

              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.off(
                      () => AdminLoginScreen(),
                      transition: Transition.rightToLeft,
                    );
                  },
                  child: Text(
                    "Login as an Admin",
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
    );
  }
}
