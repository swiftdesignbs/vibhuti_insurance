import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/shadow_btn.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';

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
      "checkup_name": "Comprehensive Health Checkup",
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
      "checkup_name": "Senior Citizen Health Check",
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
      "checkup_name": "Advanced Health Screening",
      "package_cost": "₹ 8999",
      "created_on": "2024-02-08",
      "package_name": "Premium Health Plan",
    },
  ];

  void _showPackageDetailsBottomSheet(
    BuildContext context,
    Map<String, dynamic> package,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
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
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Policy Details', style: AppTextTheme.pageTitle),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Policy Input',
                      style: AppTextTheme.pageTitle.copyWith(fontSize: 14),
                    ),

                    SizedBox(height: 10),

                    detailRow(
                      'Insurance Co',
                      "The New india assurance company Limited",
                    ),
                    detailRow('Policy No', "1234567890"),
                    detailRow(
                      'Policy Name.',
                      "Flexi Floater Group Mediclaim policy",
                    ),
                    detailRow('Policy Type', "Regular"),
                    detailRow('Policy Start', "26/09/2023"),
                    detailRow('Policy End', "25/09/2024"),
                    detailRow('Gender', "Female"),
                    detailRow('Sum Insured', "₹ 5,00,000"),
                    detailRow('Health Card No.', "MN1234567890"),
                    detailRow('No Of Dependent Covered', "2"),

                    SizedBox(height: 10),

                    Row(
                      children: [
                        Wrap(
                          spacing: 5, // horizontal space between cards
                          runSpacing: 10, // vertical space between rows
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
                      ],
                    ),
                    const SizedBox(height: 20),

                    //  _buildDownloadButton("Health Card"),
                    DottedBorderBtn(
                      label: "Health Card",
                      iconPath: 'assets/icons/download_green.png',
                    ),
                    const SizedBox(height: 16),
                    // _buildDownloadButton("Policy Copy"),
                    DottedBorderBtn(
                      label: "Policy Copy",
                      iconPath: 'assets/icons/download_green.png',
                    ),
                    const SizedBox(height: 20),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Terms & Conditions",
                          style: AppTextTheme.paragraph.copyWith(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        buildBulletPoint(
                          "Policy Type: Floater (Single Sum Insured Will Be Float Within The Family)",
                        ),
                        buildBulletPoint("Sum Insured: 10 Lakhs Floater"),
                        buildBulletPoint(
                          "Definition Of Family: Employee + Spouse + Children Only",
                        ),
                        buildBulletPoint("Room Rent: Single Private Room"),
                        buildBulletPoint("IC/ICCU: No Cap"),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //    _buildDownloadButton("FAQ Document"),
                    DottedBorderBtn(
                      label: "FAQ Document",
                      iconPath: 'assets/icons/download_green.png',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget _buildDownloadButton(String label) {
  //   return DottedBorder(
  //     options: RoundedRectDottedBorderOptions(
  //       radius: Radius.circular(30),
  //       strokeWidth: 2,
  //       dashPattern: [6, 4],
  //       color: AppTextTheme.primaryColor,
  //     ),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(30),

  //         color: const Color(0xFFE5F8F7),
  //       ),

  //       child: Padding(
  //         padding: const EdgeInsets.all(4.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Image.asset(
  //               'assets/icons/download_green.png',
  //               height: 42,
  //               width: 42,
  //             ),
  //             const SizedBox(width: 8),
  //             Text(
  //               label,
  //               style: AppTextTheme.coloredButtonText.copyWith(
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  final List<String> _filters = [
    'Health',
    'Life',
    'Motor',
    'Travel',
    'Home',
    'Accident',
    'Fire',
    'Marine',
    'Property',
    'Critical Illness',
    'Pet',
    'Cyber',
    'Crop',
    'Term',
    'Group Health',
    'Personal Accident',
  ];
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 45,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = selectedFilter == filter;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: AppTextTheme.primaryColor,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: AppTextTheme.primaryColor),
                        onSelected: (bool selected) {
                          setState(() {
                            selectedFilter = selected ? filter : '';
                          });
                        },
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: 15),
              CustomTextField(
                controller: searchController,
                hintText: "Search",
                suffixIcon: "assets/icons/search_color.png",
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: insurancePackages.length,
                  itemBuilder: (context, index) {
                    final package = insurancePackages[index];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppTextTheme.primaryColor),
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
                                  SizedBox(width: 10),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '1234567890',
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
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
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

Widget detailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: Text(label, style: AppTextTheme.subItemTitle)),
        Expanded(flex: 3, child: Text(value, style: AppTextTheme.subTitle)),
      ],
    ),
  );
}
