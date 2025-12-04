import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/admin_login.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/admin_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'login_screen.dart';

class LoginSelection extends StatefulWidget {
  const LoginSelection({super.key});

  @override
  State<LoginSelection> createState() => _LoginSelectionState();
}

class _LoginSelectionState extends State<LoginSelection> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isSmallDevice = screenSize.width < 370;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            // top: isSmallDevice ? -180 : -60,
            // left: isSmallDevice ? -180 : -100,
            // child: _buildBlurCircle(isSmallDevice ? 460 : 500, [
            //   Color(0xFF00635F).withOpacity(0.10),
            //   Color(0xFF00635F).withOpacity(0.05),
            // ]),
            child: Image.asset(
              'assets/icons/login_BG1.png',
              width: isSmallDevice ? 300 : 400,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: 0,
            //left: isSmallDevice ? -150 : -180,

            // child: _buildBlurCircle(isSmallDevice ? 360 : 500, [
            //   Color(0xFF00635F).withOpacity(0.10),
            //   Color(0xFF00635F).withOpacity(0.05),
            // ]),
            child: Image.asset(
              'assets/icons/login_BG2.png',
              width: isSmallDevice ? 300 : 400,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallDevice ? 16.0 : 24.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Hero(
                        tag: 'app_logo',
                        child: SvgPicture.asset(
                          'assets/icons/vib-logo-full-old.svg',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        "Your guide for a\nsafe future!",
                        textAlign: TextAlign.center,
                        style: AppTextTheme.pageTitle.copyWith(
                          color: Colors.black,
                          fontSize: isSmallDevice ? 34 : 40,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: isSmallDevice ? 40 : 60),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: AutoSizeText(
                          "Login as",
                          style: AppTextTheme.pageTitle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: AdmibBtn(
                              width: double.infinity,
                              ddName: "Admin",
                              onPressed: () {
                                Get.to(() => const AdminLoginScreen());
                              },
                            ),
                          ),
                          SizedBox(width: isSmallDevice ? 12 : 16),
                          Expanded(
                            child: Buttons(
                              width: double.infinity,
                              ddName: "Employee",
                              onPressed: () {
                                Get.to(() => const LoginScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurCircle(double size, List<Color> colors) {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: colors,
              center: Alignment.center,
              radius: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
