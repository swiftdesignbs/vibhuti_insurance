import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class DottedBorderBtn extends StatelessWidget {
  final String label;
  final String? iconPath; // ✅ Image asset path instead of IconData

  const DottedBorderBtn({super.key, required this.label, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(30),
        strokeWidth: 2,
        dashPattern: [6, 4],
        color: AppTextTheme.primaryColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),

          color: const Color(0xFFE5F8F7),
        ),

        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath ?? '',
                // 'assets/icons/download_green.png',
                height: 42,
                width: 42,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextTheme.coloredButtonText.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
