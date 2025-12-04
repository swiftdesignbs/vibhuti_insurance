import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class DottedBorderBtn extends StatelessWidget {
  final String label;
  final String? iconPath; // ✅ Image asset path instead of IconData
  final double height; // Adjustable height
  final VoidCallback? onPressed;
  const DottedBorderBtn({
    super.key,
    this.onPressed,
    required this.label,
    this.iconPath,
    this.height = 55, // Default height
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(35),
          strokeWidth: 2,
          dashPattern: [6, 4],
          color: AppTextTheme.primaryColor,
        ),
        child: Container(
          height: height,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color(0xFFE5F8F7),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // ✅ Width adjusts to content
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconPath != null && iconPath!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    right: 8.0,
                  ), // Only right padding to separate from text
                  child: SizedBox(
                    width: 20, // Fixed small size container
                    height: 20,
                    child: SvgPicture.asset(
                      iconPath!,
                      height: 16, // Actual icon size
                      width: 16,
                      fit: BoxFit.contain,
                      colorFilter: const ColorFilter.mode(
                        AppTextTheme.primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              if (iconPath != null && iconPath!.isNotEmpty)
                const SizedBox(width: 4),
              if (iconPath != null && iconPath!.isNotEmpty)
                const SizedBox(width: 8),
              Text(
                label,
                style: AppTextTheme.coloredButtonText.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
