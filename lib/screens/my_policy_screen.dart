import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/policy_benefit_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/shadow_btn.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';

class MyPolicyScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const MyPolicyScreen({super.key, this.scaffoldKey});

  @override
  State<MyPolicyScreen> createState() => _MyPolicyScreenState();
}

class _MyPolicyScreenState extends State<MyPolicyScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController appointmentDate1Controller = TextEditingController();
  TextEditingController appointmentDate2Controller = TextEditingController();

  List<Map<String, dynamic>> insurancePackages = [
    {
      "name": "John Smith",
      "checkup_name": "Health Checkup",
      "package_cost": "₹ 4999",
      "created_on": "2024-01-15",
      "package_name": "Gold Health Plan",
    },
    {
      "name": "Emma Wilson",
      "checkup_name": "Basic Health Screening",
      "package_cost": "₹ 2499",
      "created_on": "2024-01-18",
      "package_name": "Silver Health Plan",
    },
    {
      "name": "Michael Brown",
      "checkup_name": "Executive Health Checkup",
      "package_cost": "₹ 7999",
      "created_on": "2024-01-20",
      "package_name": "Platinum Health Plan",
    },
    {
      "name": "Sarah Johnson",
      "checkup_name": "Cardiac Health Checkup",
      "package_cost": "₹ 5999",
      "created_on": "2024-01-22",
      "package_name": "Cardiac Care Package",
    },
    {
      "name": "David Miller",
      "checkup_name": "Diabetes Screening",
      "package_cost": "₹ 1999",
      "created_on": "2024-01-25",
      "package_name": "Diabetes Management",
    },
    {
      "name": "Lisa Anderson",
      "checkup_name": "Women's Health Checkup",
      "package_cost": "₹ 3499",
      "created_on": "2024-01-28",
      "package_name": "Women Wellness Plan",
    },
    {
      "name": "Robert Taylor",
      "checkup_name": "Senior Citizen Health",
      "package_cost": "₹ 4599",
      "created_on": "2024-02-01",
      "package_name": "Senior Care Package",
    },
    {
      "name": "Maria Garcia",
      "checkup_name": "Full Body Checkup",
      "package_cost": "₹ 6999",
      "created_on": "2024-02-03",
      "package_name": "Comprehensive Care",
    },
    {
      "name": "James Wilson",
      "checkup_name": "Basic Diagnostic Tests",
      "package_cost": "₹ 1599",
      "created_on": "2024-02-05",
      "package_name": "Essential Health Plan",
    },
    {
      "name": "Patricia Davis",
      "checkup_name": "Health Screening",
      "package_cost": "₹ 8999",
      "created_on": "2024-02-08",
      "package_name": "Premium Health Plan",
    },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('My Dependent', style: AppTextTheme.pageTitle),
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

  void _showPackageDetailsBottomSheet(
    BuildContext context,
    Map<String, dynamic> package,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2), // Optional dimming

      backgroundColor: Colors.transparent,
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
                heightFactor: 0.85,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
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
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Center(
                          child: Container(
                            height: 5,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Color(0xff004370),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Policy Details',
                              style: AppTextTheme.pageTitle,
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Policy Input',
                                  style: AppTextTheme.pageTitle.copyWith(
                                    fontSize: 14,
                                  ),
                                ),

                                SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    detailBlock(
                                      'Insurance Co',
                                      "The New India Assurance Company Limited",
                                      context,
                                    ),
                                    detailBlock(
                                      'Policy Name',
                                      "Flexi Floater Group Mediclaim policy",
                                      context,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    detailBlock(
                                      'Policy No',
                                      "1234567890",
                                      context,
                                    ),

                                    detailBlock(
                                      'Policy Type',
                                      "Regular",
                                      context,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    detailBlock(
                                      'Policy Start',
                                      "26/09/2023",
                                      context,
                                    ),
                                    detailBlock(
                                      'Policy End',
                                      "25/09/2024",
                                      context,
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    detailBlock('Gender', "Female", context),
                                    detailBlock(
                                      'Sum Insured',
                                      "₹ 5,00,000",
                                      context,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    detailBlock(
                                      'Health Card No.',
                                      "MN1234567890",
                                      context,
                                    ),
                                    detailBlock(
                                      'No Of Dependent Covered',
                                      "2",
                                      context,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 10),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        Navigator.pop(context);
                                        _showDependentBottomSheet(context);
                                      },
                                      child: Text(
                                        "View More",
                                        style: AppTextTheme.coloredSubTitle
                                            .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor:
                                                  AppTextTheme.primaryColor,
                                              decorationStyle:
                                                  TextDecorationStyle.solid,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),

                                //    SizedBox(height: 10),
                                Row(
                                  children: [
                                    Wrap(
                                      spacing:
                                          5, // horizontal space between cards
                                      runSpacing:
                                          10, // vertical space between rows
                                      children: [
                                        familyCard(
                                          context: context,
                                          iconPath:
                                              'assets/icons/circle-user.svg',
                                          title: 'Kumar Sangakara',
                                          subtitle: 'DOB: 19-07-1987',
                                        ),
                                        familyCard(
                                          context: context,
                                          iconPath:
                                              'assets/icons/circle-user.svg',
                                          title: 'Sachin Tendulkar',
                                          subtitle: 'DOB: 19-07-1987',
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                //  _buildDownloadButton("Health Card"),
                                DottedBorderBtn(
                                  label: "Health Card",
                                  iconPath: 'assets/icons/download_green.svg',
                                  height: 50,
                                ),
                                const SizedBox(height: 16),
                                // _buildDownloadButton("Policy Copy"),
                                DottedBorderBtn(
                                  label: "FAQ Documents",
                                  iconPath: 'assets/icons/download_green.svg',
                                  height: 50,
                                ),
                                // const SizedBox(height: 20),

                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       "Terms & Conditions",
                                //       style: AppTextTheme.paragraph.copyWith(
                                //         color: Colors.grey.shade600,
                                //         fontWeight: FontWeight.w600,
                                //         fontSize: 16,
                                //       ),
                                //     ),
                                //     const SizedBox(height: 12),
                                //     buildBulletPoint(
                                //       "Policy Type: Floater (Single Sum Insured Will Be Float Within The Family)",
                                //     ),
                                //     buildBulletPoint(
                                //       "Sum Insured: 10 Lakhs Floater",
                                //     ),
                                //     buildBulletPoint(
                                //       "Definition Of Family: Employee + Spouse + Children Only",
                                //     ),
                                //     buildBulletPoint(
                                //       "Room Rent: Single Private Room",
                                //     ),
                                //     buildBulletPoint("IC/ICCU: No Cap"),
                                //   ],
                                // ),

                                // const SizedBox(height: 20),

                                //    _buildDownloadButton("FAQ Document"),
                                SizedBox(height: 20),
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
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: PolicyBenefitsCard(),
                                ),
                                SizedBox(height: 30),
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

  Widget buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("•  ", style: TextStyle(fontSize: 16, color: Colors.grey)),
          Expanded(
            child: Text(
              text,
              style: AppTextTheme.paragraph.copyWith(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
              // style: const TextStyle(
              //   fontSize: 14.5,
              //   height: 1.4,
              //   color: Colors.black87,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  String selectedFilter = '';

  final List<String> _filters = ['Health', 'Life', 'Motor', 'Travel'];
  String? _selectedFilter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "My Policy",
        scaffoldKey: widget.scaffoldKey,
        showWelcomeText: false,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 60, // ⬅️ Increased height for shadow visibility
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ), // ⬅️ Extra vertical padding
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = selectedFilter == filter;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedFilter = filter;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 26,
                            // vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTextTheme.primaryColor
                                : Colors.white,
                            borderRadius: BorderRadius.circular(35),

                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Color(0XFF00635F),

                                      offset: const Offset(3, 3),
                                      blurRadius: 0,
                                    ),
                                  ]
                                : [],

                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF56B3AD)
                                  : AppTextTheme.primaryColor,
                              width: 1.2,
                            ),
                          ),

                          child: Center(
                            child: Text(
                              filter,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected
                                    ? Colors.white
                                    : Color(0XFF00635F),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 10),
              CustomTextField(
                controller: searchController,
                hintText: "Search",
                suffixIcon: "assets/icons/search_color.svg",
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: insurancePackages.length,
                  itemBuilder: (context, index) {
                    final package = insurancePackages[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 12),
                      child: Container(
                        height: 150,
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(20),
                        //   border: Border.all(color: AppTextTheme.primaryColor),
                        // ),
                        decoration: index == 0
                            ? BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTextTheme.primaryColor,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(
                                      0XFF00635F,
                                    ), // darker teal shadow
                                    offset: const Offset(
                                      6,
                                      6,
                                    ), // shadow position
                                    blurRadius: 0,
                                  ),
                                ],
                              )
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppTextTheme.primaryColor,
                                ),
                              ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        package['package_name'],
                                        style: AppTextTheme.paragraph,
                                      ),
                                      Text(
                                        '${package['name']}',
                                        style: AppTextTheme.subTitle,
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Sum Insured",
                                        style: AppTextTheme.paragraph,
                                      ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XffD8E9F1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${package['checkup_name']}',
                                        style: AppTextTheme.paragraph.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0Xff00635F),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0XffD8E9F1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '1234567890',
                                        style: AppTextTheme.paragraph.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0Xff00635F),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                _showPackageDetailsBottomSheet(
                                  context,
                                  package,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: AppTextTheme.primaryColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),

                                child: Center(
                                  child: Text(
                                    'View Details',
                                    style: AppTextTheme.buttonText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget detailBlock(String label, String value, BuildContext context) {
  final double itemWidth = MediaQuery.of(context).size.width / 2 - 24;

  return SizedBox(
    width: itemWidth,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextTheme.subItemTitle.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: AppTextTheme.subItemTitle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
