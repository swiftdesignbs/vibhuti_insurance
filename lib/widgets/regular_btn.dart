import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class Buttons extends StatelessWidget {
  final double width;
  final VoidCallback? onPressed;
  final String? iconPath; // ✅ Image asset path instead of IconData

  final String ddName;

  const Buttons({
    Key? key,
    required this.onPressed,
    required this.ddName,

    required this.width,
    this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    return Container(
      decoration: BoxDecoration(
        color: AppTextTheme.primaryColor,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D7C78),
            offset: const Offset(6, 6),
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
          minimumSize: Size(width, 50),
          backgroundColor: AppTextTheme.primaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null) ...[
              Image.asset(
                iconPath!,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              ddName,
              style: AppTextTheme.buttonText.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 15 * textScale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
