import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class Buttons extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final String ddName;

  //final Color textColors;

  const Buttons({
    Key? key,
    required this.onPressed,
    required this.ddName,
    required this.height,
    required this.width,

    //required this.textColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF56B3AD), // teal shade (like in image)
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D7C78), // darker teal shadow
            offset: const Offset(6, 6), // shadow position
            blurRadius: 1,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          minimumSize: Size(width, height),
          backgroundColor: AppTextTheme.primaryColor,
        ),
        child: Text(
          ddName,
          style: AppTextTheme.buttonText.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
