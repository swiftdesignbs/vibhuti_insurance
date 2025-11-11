import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';

import 'package:vibhuti_insurance_mobile_app/screens/login_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.off(() => LoginScreen(), transition: Transition.leftToRightWithFade);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icons/asset_1.png', width: 150, height: 150),
            SizedBox(height: 20),
            Text(
              "VIBHUTI",
              style: AppTextTheme.pageTitle.copyWith(
                letterSpacing: 1.5,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
