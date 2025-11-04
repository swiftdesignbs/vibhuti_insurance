import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';

class WellnessServicesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const WellnessServicesScreen({super.key, this.scaffoldKey});

  @override
  State<WellnessServicesScreen> createState() => _WellnessServicesScreenState();
}

class _WellnessServicesScreenState extends State<WellnessServicesScreen> {
  final List<Map<String, dynamic>> carouselIcons = [
    {"icon": "assets/icons/wellness_8.png", "label": "Health Checkup"},
    {
      "icon": "assets/icons/big_wellness_van.png",
      "label": "Home Sample Collection",
    },
    {"icon": "assets/icons/big_wellness_tooth.png", "label": "Dental Checkup"},
    {"icon": "assets/icons/big_wellness_eye.png", "label": "Vision Checkup"},
    {"icon": "assets/icons/wellness_3.png", "label": "OPD Benefits"},
    {"icon": "assets/icons/search.png", "label": "Explore More"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Wellness Services", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () {
            if (widget.scaffoldKey != null) {
              widget.scaffoldKey!.currentState?.openDrawer();
            } else {
              Scaffold.of(context).openDrawer();
            }
          },
          icon: Image.asset('assets/icons/menu.png', height: 24, width: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade200,
              child: Image.asset(
                'assets/icons/profile_icon.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 20,
              childAspectRatio: 0.9,
            ),
            itemCount: carouselIcons.length,
            itemBuilder: (context, index) {
              final item = carouselIcons[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:  EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDECEB),
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Image.asset(item['icon'], height: 56, width: 56),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['label'],
                    textAlign: TextAlign.center,
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xFF00635F),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
