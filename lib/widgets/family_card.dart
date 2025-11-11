import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

Widget familyCard({
  required String iconPath,
  required String title,
  required String subtitle,
  required BuildContext context,
}) {
  return Container(
    width: (MediaQuery.of(context).size.width / 2) - 25,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: AppTextTheme.primaryColor),
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: AppTextTheme.primaryColor,
          child: Image.asset(iconPath, height: 24, width: 24),
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
