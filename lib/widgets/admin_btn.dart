import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class AdmibBtn extends StatelessWidget {
  final double width;
  final VoidCallback? onPressed;
  final String? iconPath; // ✅ Image asset path instead of IconData

  final String ddName;

  const AdmibBtn({
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
        color: Color(0xff004370),
        borderRadius: BorderRadius.circular(50),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black,
        //     offset: const Offset(6, 6),
        //     blurRadius: 1,
        //   ),
        // ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          minimumSize: Size(width, 50),
          backgroundColor: Color(0xff004370),
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
