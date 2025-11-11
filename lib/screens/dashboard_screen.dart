import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/vision_check_up.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/policy_benefit_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class DashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DashboardScreen({super.key, this.scaffoldKey});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController carouselController = PageController();
  int _currentIndex = 0;

  final List<Map<String, dynamic>> carouselIcons = [
    {
      "icon": "assets/icons/wellness_8.png",
      "label": "Health Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_1.png",
      "label": "Home Sample Collection",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_5.png",
      "label": "Dental Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_4.png",
      "label": "Vision Checkup",
      "route": VisionCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_3.png",
      "label": "OPD Benefits",
      "route": HealthCheckUpScreen(),
    },
  ];

  final List<Map<String, String>> nameList = [
    {"label": "Under Process"},
    {"label": "Settled"},
    {"label": "Query"},
  ];

  void _showDependentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dependent', style: AppTextTheme.pageTitle),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Kumar Sangakara',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Sachin Tendulkar',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Kumar Sangakara',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Sachin Tendulkar',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Kumar Sangakara',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Sachin Tendulkar',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Kumar Sangakara',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Sachin Tendulkar',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Kumar Sangakara',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                          familyCard(
                            context: context,
                            iconPath: 'assets/icons/circle-user.png',
                            title: 'Sachin Tendulkar',
                            subtitle: 'DOB: 19-07-1987',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Dashboard",
        userName: "Krishnan Murthy",
        scaffoldKey: widget.scaffoldKey,
        showWelcomeText: true,
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
                child: Image.asset(
                  'assets/icons/profile_icon.png',
                  height: 24,
                  width: 24,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Health Card Quick View",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/icons/msg_green.png',
                        height: 42,
                        width: 42,
                      ),

                      Image.asset(
                        'assets/icons/download_green.png',
                        height: 42,
                        width: 42,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),

              // CarouselSlider(
              //   carouselController: CarouselSliderController(),
              //   options: CarouselOptions(
              //     height: 140,
              //     enlargeCenterPage: true,
              //     autoPlay: true,
              //     aspectRatio: 16 / 9,
              //     enableInfiniteScroll: true,
              //     autoPlayAnimationDuration: const Duration(milliseconds: 500),
              //     viewportFraction: 1,
              //     clipBehavior: Clip.none, // 👈 allow shadow to overflow

              //     onPageChanged: (index, reason) {
              //       setState(() {
              //         _currentIndex = index;
              //       });
              //     },
              //   ),
              //   items: carouselItems.map((item) {
              //     return
              //   }).toList(),
              // ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2D7C78),
                      offset: const Offset(6, 6),
                      blurRadius: 1,
                    ),
                  ],
                  border: Border.all(
                    color: const Color(0xFF56B3AD),
                    width: 1.2,
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppTextTheme.primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Policy No: 1234567890',
                            style: AppTextTheme.buttonText,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Sum Insured: ',
                                        style: AppTextTheme.paragraph.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '₹10,00,000',
                                        style: AppTextTheme.paragraph,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),

                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Start Date: ',
                                        style: AppTextTheme.paragraph.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '15 Feb 2025',
                                        style: AppTextTheme.paragraph,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Covers: ',
                                          style: AppTextTheme.paragraph
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        TextSpan(
                                          text: 'Health Accident',
                                          style: AppTextTheme.paragraph,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'End Date: ',
                                          style: AppTextTheme.paragraph
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                        TextSpan(
                                          text: '14 Feb 2025',
                                          style: AppTextTheme.paragraph,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'TPA: ',
                                style: AppTextTheme.paragraph.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'HDFC Ergo TPA',
                                style: AppTextTheme.paragraph,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Dependent",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _showDependentBottomSheet(context);
                    },
                    child: Text(
                      "View More",
                      style: AppTextTheme.coloredSubTitle.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              // Center(
              //   child: AnimatedSmoothIndicator(
              //     activeIndex: _currentIndex,
              //     count: carouselItems.length,
              //     effect: ExpandingDotsEffect(
              //       dotWidth: 5,
              //       dotHeight: 5,
              //       dotColor: AppTextTheme.primaryColor,
              //       activeDotColor: Color(0xFF00635F),
              //       paintStyle: PaintingStyle.stroke,
              //       strokeWidth: 5,
              //     ),
              //   ),
              // ),
              // SizedBox(height: 10),
              Wrap(
                spacing: 5, // horizontal space between cards
                runSpacing: 5, // vertical space between rows
                children: [
                  familyCard(
                    context: context,
                    iconPath: 'assets/icons/circle-user.png',
                    title: 'Kumar Sangakara',
                    subtitle: 'DOB: 19-07-1987',
                  ),
                  familyCard(
                    context: context,
                    iconPath: 'assets/icons/circle-user.png',
                    title: 'Sachin Tendulkar',
                    subtitle: 'DOB: 19-07-1987',
                  ),
                ],
              ),

              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Policy Benefits",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              PolicyBenefitsCard(),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "What are you looking for?",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  actionCard('My Policy', 'assets/icons/my_policy.png'),
                  actionCard('Claims', 'assets/icons/claims.png'),
                  actionCard('My Family', 'assets/icons/wellness_6.png'),
                  actionCard('Network List', 'assets/icons/wellness_7.png'),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Wellness Services",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFBDECEB),

                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Booking List",
                        style: AppTextTheme.subTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xFF00635F),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: carouselIcons.length,

                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        pushScreen(
                          context,
                          screen: carouselIcons[index]['route'],
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppTextTheme.primaryColor,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  carouselIcons[index]['icon'],
                                  height: 30,
                                  width: 30,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              carouselIcons[index]['label'],
                              textAlign: TextAlign.center,
                              style: AppTextTheme.subItemTitle.copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "View Claims",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 4.5,
                ),
                itemCount: nameList.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFBDECEB),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        nameList[index]['label']!,
                        textAlign: TextAlign.center,
                        style: AppTextTheme.subTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color(0xFF00635F),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Container(
                width: 220,
                height: 220,

                decoration: BoxDecoration(
                  color: const Color(0xFF00635F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTextTheme.primaryColor),
                  boxShadow: [
                    BoxShadow(
                      color: AppTextTheme.primaryColor,
                      offset: const Offset(10, 8),
                    ),
                  ],
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    "assets/icons/asset_1.png",

                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 20),

              Text(
                "Buy Travel Insurance",
                style: AppTextTheme.pageTitle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Protect your trip with travel insurance!",
                style: AppTextTheme.subItemTitle.copyWith(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20),
              Buttons(onPressed: () {}, ddName: "Coming Soon", width: 150),
            ],
          ),
        ),
      ),
    );
  }

  Widget actionCard(String title, String iconPath) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: AppTextTheme.primaryColor, width: 1),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              height: 28,
              width: 28,
              color: Color(0xff004370),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: AppTextTheme.subItemTitle.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
