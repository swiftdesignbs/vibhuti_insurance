import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

Widget familyCard({
  required String iconPath,
  required String title,
  required String subtitle,
  required BuildContext context,
}) {
  return Container(
    width: (MediaQuery.of(context).size.width / 2) - 25,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: AppTextTheme.primaryColor),
      borderRadius: BorderRadius.circular(14),
      color: Colors.white,
    ),
    child: Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: const Offset(2, 2),
                blurRadius: 0,
              ),
            ],
            border: Border.all(color: const Color(0xFF56B3AD), width: 1.2),
          ),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: AppTextTheme.primaryColor,
            child: SvgPicture.asset(iconPath, height: 22, width: 22),
            // child: SvgPicture.asset(iconPath, height: 24, width: 24),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.subItemTitle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: AppTextTheme.paragraph.copyWith(fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
