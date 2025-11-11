import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';

class WellnessServicesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const WellnessServicesScreen({super.key, this.scaffoldKey});

  @override
  State<WellnessServicesScreen> createState() => _WellnessServicesScreenState();
}

class _WellnessServicesScreenState extends State<WellnessServicesScreen> {
  final List<Map<String, dynamic>> carouselIcons = [
    {
      "icon": "assets/icons/wellness_8.png",
      "label": "Health Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/big_wellness_van.png",
      "label": "Home Sample Collection",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/big_wellness_tooth.png",
      "label": "Dental Checkup",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/big_wellness_eye.png",
      "label": "Vision Checkup",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_3.png",
      "label": "OPD Benefits",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/search.png",
      "label": "Explore More",
      "route": DentalCheckUpScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Wellness Services",
        scaffoldKey: widget.scaffoldKey,
        showWelcomeText: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: carouselIcons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final item = carouselIcons[index];
              return InkWell(
                onTap: () {
                  pushScreen(
                    context,
                    screen: item['route'],
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
