import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class FamilyCardTwo extends StatelessWidget {
  final String name;
  final String dob;
  final String dependent;
  final String doc;

  const FamilyCardTwo({
    Key? key,
    required this.name,
    required this.dob,
    required this.dependent,
    required this.doc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: AppTextTheme.primaryColor, width: 1),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.25),
            offset: const Offset(-2, 3), // shadow on opposite side
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppTextTheme.primaryColor,
            child: SvgPicture.asset(
              "assets/icons/circle-user.svg",
              height: 28,
              width: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: AppTextTheme.subItemTitle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "|",
                      style: AppTextTheme.subItemTitle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "$dependent",
                      style: AppTextTheme.subItemTitle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      "DOB: $dob",
                      style: AppTextTheme.paragraph.copyWith(fontSize: 12),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "|",
                      style: AppTextTheme.subItemTitle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "DOC: $doc",
                      style: AppTextTheme.paragraph.copyWith(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
  // Buttons(
  //               onPressed: () {},
  //               ddName: "Add Dependent",
  //               height: 45,
  //               width: double.infinity,
  //               icon: Icons.add,
  //             ),