import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login_selection.dart';
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
      Get.off(
        () => LoginSelection(),
        transition: Transition.leftToRightWithFade,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff004370),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                'assets/icons/vib-logo-old.svg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
