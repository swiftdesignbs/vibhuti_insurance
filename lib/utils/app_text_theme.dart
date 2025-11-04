import 'package:flutter/material.dart';

class AppTextTheme {
  static const double pageTitleSize = 18;
  static const double buttonTextSize = 16;
  static const double subTitleSize = 14;
  static const double subItemTitleSize = 12;
  static const double paragraphSize = 10;

  static const Color primaryColor = Color(0xFF00B3AC);
  static const Color appBarColor = Color(0xFFC7E1E9);

  // Text styles
  static const TextStyle pageTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: pageTitleSize,
    fontWeight: FontWeight.w700, // Bold
    color: Color(0xff004370),
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: buttonTextSize,
    fontWeight: FontWeight.w700, // Medium
    color: Colors.white,
  );

  static const TextStyle subTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: subTitleSize,
    fontWeight: FontWeight.w700, // Bold
    color: Color(0xff004370),
  );

  static const TextStyle subItemTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: subItemTitleSize,
    fontWeight: FontWeight.w500, // Medium
    color: Color(0xff004370),
  );

  static const TextStyle paragraph = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: paragraphSize,
    fontWeight: FontWeight.w500, // Medium
    color: Color(0xff004370),
  );

  // Colored text styles
  static const TextStyle coloredButtonText = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: buttonTextSize,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );

  static const TextStyle coloredSubTitle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: subTitleSize,
    fontWeight: FontWeight.w700,
    color: primaryColor,
  );
}
