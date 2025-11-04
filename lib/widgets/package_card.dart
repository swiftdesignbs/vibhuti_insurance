import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class PackageDetailsCard extends StatelessWidget {
  const PackageDetailsCard({super.key, required this.package});

  final Map<String, dynamic> package;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,

      decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: AppTextTheme.primaryColor),
  
  color: Colors.white,
),

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      package['package_name'],
                      style: AppTextTheme.paragraph,
                    ),
                    Text('${package['name']}', style: AppTextTheme.subTitle),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Package Cost", style: AppTextTheme.paragraph),
                    Text(
                      '${package['package_cost']}',
                      style: AppTextTheme.subTitle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Created On: ${package['created_on']}',
                      style: AppTextTheme.paragraph.copyWith(
                        color: AppTextTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),

                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${package['checkup_name']}',
                      style: AppTextTheme.paragraph.copyWith(
                        color: AppTextTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            height: 45,
            decoration: BoxDecoration(
              color: AppTextTheme.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),

            child: Center(
              child: Text('View Details', style: AppTextTheme.buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
