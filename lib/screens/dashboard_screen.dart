import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

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
      "icon": "assets/icons/wellness_8.svg",
      "label": "Health Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_1.svg",
      "label": "Home Sample Collection",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_5.svg",
      "label": "Dental Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_4.svg",
      "label": "Vision Checkup",
      "route": VisionCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_3.svg",
      "label": "OPD Benefits",
      "route": HealthCheckUpScreen(),
    },
  ];

  final List<Map<String, String>> nameList = [
    {"label": "Under Process"},
    {"label": "Settled"},
    {"label": "Query"},
  ];

  final List<String> actionItems = [
    "assets/icons/my_policy.svg",
    "assets/icons/claims.svg",
    "assets/icons/wellness_6.svg",
    "assets/icons/wellness_7.svg",
  ];

  final List<String> titles = [
    "My Policy",
    "Claims",
    "My Family",
    "Network List",
  ];

  void _showDependentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.2), // Optional dimming

      builder: (context) {
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4), // amount of blur
              child: Container(
                color: Colors.black.withOpacity(0.1), // light transparent layer
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: FractionallySizedBox(
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
                        SizedBox(height: 10),
                        Container(
                          height: 5,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Color(0xff004370),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'My Dependent',
                                style: AppTextTheme.pageTitle,
                              ),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
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
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Kumar Sangakara',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Sachin Tendulkar',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Kumar Sangakara',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Sachin Tendulkar',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Kumar Sangakara',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Sachin Tendulkar',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Kumar Sangakara',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Sachin Tendulkar',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
                                  title: 'Kumar Sangakara',
                                  subtitle: 'DOB: 19-07-1987',
                                ),
                                familyCard(
                                  context: context,
                                  iconPath: 'assets/icons/circle-user.svg',
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
              ),
            ),
          ],
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
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(4, 4), // X, Y offset
                      blurRadius: 0, // No blur
                      spreadRadius: 0,
                    ),
                  ],
                ),
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
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 10,
            bottom: 0,
          ),
          child: Column(
            children: [
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
                      SvgPicture.asset(
                        'assets/icons/msg_green.svg',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      SvgPicture.asset(
                        'assets/icons/download_green.svg',
                        height: 23,
                        width: 24,
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
                      // color: const Color(0xFF2D7C78),
                      color: Color(0XFF00635F),

                      offset: const Offset(6, 6),
                      blurRadius: 0,
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
                                Text(
                                  "Sum Insured",
                                  style: AppTextTheme.paragraph,
                                ),
                                Text(
                                  "2000000",
                                  style: AppTextTheme.subTitle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                // Text.rich(
                                //   TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text: 'Sum Insured: ',
                                //         style: AppTextTheme.paragraph.copyWith(
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       TextSpan(
                                //         text: '₹10,00,000',
                                //         style: AppTextTheme.paragraph,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                const SizedBox(height: 5),

                                // Text.rich(
                                //   TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text: 'Start Date: ',
                                //         style: AppTextTheme.paragraph.copyWith(
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       TextSpan(
                                //         text: '15 Feb 2025',
                                //         style: AppTextTheme.paragraph,
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                Text(
                                  "Start Date",
                                  style: AppTextTheme.paragraph,
                                ),
                                Text(
                                  "18-Apr-2023",
                                  style: AppTextTheme.subTitle.copyWith(
                                    fontSize: 12,
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
                                  // Text.rich(
                                  //   TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text: 'Covers: ',
                                  //         style: AppTextTheme.paragraph
                                  //             .copyWith(
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: 'Health Accident',
                                  //         style: AppTextTheme.paragraph,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Text("Covers", style: AppTextTheme.paragraph),
                                  Text(
                                    "Health Accident",
                                    style: AppTextTheme.subTitle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 10),

                                  // Text.rich(
                                  //   TextSpan(
                                  //     children: [
                                  //       TextSpan(
                                  //         text: 'End Date: ',
                                  //         style: AppTextTheme.paragraph
                                  //             .copyWith(
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //       ),
                                  //       TextSpan(
                                  //         text: '14 Feb 2025',
                                  //         style: AppTextTheme.paragraph,
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Text(
                                    "End Date",
                                    style: AppTextTheme.paragraph,
                                  ),
                                  Text(
                                    "14-Feb-2025",
                                    style: AppTextTheme.subTitle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text("TPA", style: AppTextTheme.paragraph),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Vidal Health Insurance Pvt Ltd",
                          style: AppTextTheme.subTitle.copyWith(fontSize: 12),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 12),
                      //   child: Text.rich(
                      //     TextSpan(
                      //       children: [
                      //         TextSpan(
                      //           text: 'TPA: ',
                      //           style: AppTextTheme.paragraph.copyWith(
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //         TextSpan(
                      //           text: 'HDFC Ergo TPA',
                      //           style: AppTextTheme.paragraph,
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
                        // decoration: TextDecoration.underline,
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
                spacing: 25, // horizontal space between cards
                // runSpacing: 5, // vertical space between rows
                children: [
                  familyCard(
                    context: context,
                    iconPath: 'assets/icons/circle-user.svg',
                    title: 'Kumar Sangakara',
                    subtitle: 'DOB: 19-07-1987',
                  ),
                  familyCard(
                    context: context,
                    iconPath: 'assets/icons/circle-user.svg',
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

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
                ),
                itemCount: actionItems.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // TODO: Add navigation here based on index
                      print("Clicked: ${titles[index]}");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),

                      decoration: index == 0
                          ? BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  // color: const Color(0xFF2D7C78),
                                  color: Color(0XFF00635F),

                                  offset: const Offset(6, 6),
                                  blurRadius: 0,
                                ),
                              ],
                              border: Border.all(
                                color: const Color(0xFF56B3AD),
                                width: 1.2,
                              ),
                            )
                          : BoxDecoration(
                              border: Border.all(
                                color: Color(0XFF00635F),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            actionItems[index],
                            height: 28,
                            width: 28,
                            color: const Color(0xff004370),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            titles[index], // 🔥 FIXED - Now displays correct text
                            style: AppTextTheme.subItemTitle.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
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

                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Booking List",
                        style: AppTextTheme.subTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
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
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: carouselIcons[index]['route'],
                          withNavBar: true, // OPTIONAL VALUE. True by default.
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
                                child: SvgPicture.asset(
                                  carouselIcons[index]['icon'],
                                  color: Colors.black,
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
                                color: Colors.black,
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
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2.5,
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
                          fontWeight: FontWeight.w600,
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
                  child: SvgPicture.asset(
                    "assets/icons/asset_1.svg",
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
            SvgPicture.asset(
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
