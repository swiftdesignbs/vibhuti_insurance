import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:vibhuti_insurance_mobile_app/screens/dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';

class WellnessServicesScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const WellnessServicesScreen({super.key, required this.scaffoldKey});

  @override
  State<WellnessServicesScreen> createState() => _WellnessServicesScreenState();
}

class _WellnessServicesScreenState extends State<WellnessServicesScreen> {
  final List<Map<String, dynamic>> carouselIcons = [
    {
      "icon": "assets/icons/wellness_8.svg",
      "label": "Health Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/big_wellness_van.svg",
      "label": "Home Sample Collection",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/big_wellness_tooth.svg",
      "label": "Dental Checkup",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/big_wellness_eye.svg",
      "label": "Vision Checkup",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_4.svg",
      "label": "OPD Benefits",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/search.svg",
      "label": "Explore More",
      "route": DentalCheckUpScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      drawer: AppDrawer(
        scaffoldKey: widget.scaffoldKey,
        parentContext: context,
      ),
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text(
          'Wellness Services',
          style: AppTextTheme.pageTitle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            height: 16,
            width: 16,
          ),
          onPressed: () {
            widget.scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  'assets/icons/profile_icon.svg',
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
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
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: item['route'],
                    withNavBar: true, // OPTIONAL VALUE. True by default.
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
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          item['icon'],
                          height: 34,
                          width: 34,
                        ),
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
