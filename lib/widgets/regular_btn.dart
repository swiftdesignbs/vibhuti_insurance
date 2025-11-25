import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            blurRadius: 0,
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
              SvgPicture.asset(
                iconPath!,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
            ],
            AutoSizeText(
              ddName,
              style: AppTextTheme.buttonText.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14 * textScale,
              ),
            ),
          ],
        ),
      ),
    );
  }
}






class FilterButtons extends StatelessWidget {
  final double width;
  final VoidCallback? onPressed;
  final String? iconPath; // ✅ Image asset path instead of IconData

  final String ddName;
  final bool? isActive;
  const FilterButtons({
    Key? key,
    required this.onPressed,
    required this.ddName,

    required this.width,
    this.iconPath,
    this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textScale = MediaQuery.of(context).textScaleFactor;
    final bool active = isActive ?? false;
    return Container(
      decoration: active
          ? BoxDecoration(
              color: active ? AppTextTheme.primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(50),

              boxShadow: [
                BoxShadow(
                  color: Color(0XFF00635F),
                  offset: const Offset(6, 6),
                  blurRadius: 0,
                ),
              ],
            )
          : BoxDecoration(
              border: Border.all(
                color: active ? Colors.white : Color(0XFF00635F),
              ),
              color: active ? Color(0XFF00635F) : Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          minimumSize: Size(width, 50),
          backgroundColor: active ? AppTextTheme.primaryColor : Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconPath != null) ...[
              SvgPicture.asset(
                iconPath!,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
              const SizedBox(width: 8),
            ],
            AutoSizeText(
              ddName,
              style: AppTextTheme.buttonText.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14 * textScale,
                color: active ? Colors.white : Color(0XFF00635F),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
