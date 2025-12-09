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
import 'dart:math' as math;

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
          // Positioned(
          //   // top: isSmallDevice ? -180 : -60,
          //   // left: isSmallDevice ? -180 : -100,
          //   // child: _buildBlurCircle(isSmallDevice ? 460 : 500, [
          //   //   Color(0xFF00635F).withOpacity(0.10),
          //   //   Color(0xFF00635F).withOpacity(0.05),
          //   // ]),
          //   child: Image.asset(
          //     'assets/icons/login_BG1.png',
          //     width: isSmallDevice ? 300 : 500,
          //     fit: BoxFit.cover,
          //   ),
          // ),

          // Positioned(
          //   bottom: 0,
          //   //left: isSmallDevice ? -150 : -180,

          //   // child: _buildBlurCircle(isSmallDevice ? 360 : 500, [
          //   //   Color(0xFF00635F).withOpacity(0.10),
          //   //   Color(0xFF00635F).withOpacity(0.05),
          //   // ]),
          //   child: Image.asset(
          //     'assets/icons/login_BG2.png',
          //     width: isSmallDevice ? 300 : 400,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          const BlobBackground(),

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'app_logo',
                            child: SvgPicture.asset(
                              'assets/icons/vib-logo-old.svg',
                              colorFilter: ColorFilter.mode(
                                Color(0xff004370),
                                BlendMode.srcIn,
                              ),
                              height: isSmallDevice ? 45 : 45,
                              width: isSmallDevice ? 45 : 45,
                            ),
                          ),
                          SizedBox(width: isSmallDevice ? 8 : 12),
                          SvgPicture.asset(
                            'assets/icons/vib_half.svg',
                            fit: BoxFit.cover,
                          ),
                        ],
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

class BlobBackground extends StatefulWidget {
  const BlobBackground({super.key});

  @override
  State<BlobBackground> createState() => _BlobBackgroundState();
}

class _BlobBackgroundState extends State<BlobBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: BlobPainter(_controller.value),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: Container(color: Colors.transparent),
          ),
        );
      },
    );
  }
}

class BlobPainter extends CustomPainter {
  final double progress;
  static const Color baseColor = Color.fromARGB(
    255,
    175,
    239,
    238,
  ); // Your exact teal-green

  BlobPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final center1 = Offset(
      size.width * (0.5 + 0.4 * math.sin(progress * math.pi * 2)),
      size.height * (0.3 + 0.2 * math.cos(progress * math.pi * 2)),
    );

    final radius1 = size.width * (0.7 + 0.2 * math.sin(progress * math.pi * 4));

    paint.shader = LinearGradient(
      colors: [baseColor, baseColor.withOpacity(0.1), Colors.white],
      stops: const [0.0, 0.6, 1.0],
    ).createShader(Rect.fromCircle(center: center1, radius: radius1));

    canvas.drawCircle(center1, radius1, paint);

    // Blob 2 - Secondary for depth
    final center2 = Offset(
      size.width * (0.6 - 0.35 * math.cos(progress * math.pi * 2 * 1.3)),
      size.height * (0.7 + 0.2 * math.sin(progress * math.pi * 2 * 0.9)),
    );

    paint.shader = LinearGradient(
      colors: [baseColor.withOpacity(0.8), baseColor.withOpacity(0.0)],
    ).createShader(Rect.fromCircle(center: center2, radius: radius1 * 0.7));

    canvas.drawCircle(center2, radius1 * 0.7, paint);
  }

  @override
  bool shouldRepaint(BlobPainter old) => true;
}
