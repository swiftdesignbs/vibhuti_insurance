import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibhuti_insurance_mobile_app/screens/claim_history_pt.dart';
import 'package:vibhuti_insurance_mobile_app/screens/claims_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/claim_status_widget.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class AdminClaimHistoryPT1Screen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const AdminClaimHistoryPT1Screen({super.key, required this.scaffoldKey});

  @override
  State<AdminClaimHistoryPT1Screen> createState() =>
      _AdminClaimHistoryPT1ScreenState();
}

class _AdminClaimHistoryPT1ScreenState extends State<AdminClaimHistoryPT1Screen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController searchController = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController claimNo = TextEditingController();
  TextEditingController policyNo = TextEditingController();
  String? selectedValue;

  TextEditingController dateController = TextEditingController();
  final List<Map<String, dynamic>> healthClaims = [
    {
      "policyName": "Health Shield Gold",
      "customerName": "Rahul Sharma",
      "claimNo": "CLM-2024-001234",
      "status": "Query",
      "amount": 45000,
      "date": "15-01-2014",
      "hospital": "Apollo Hospital",
    },
    {
      "policyName": "Family Health Plus",
      "customerName": "Priya Patel",
      "claimNo": "CLM-2024-001235",
      "status": "Under Process",
      "amount": 32000,
      "date": "18-01-2024",
      "hospital": "Fortis Hospital",
    },
    {
      "policyName": "Corporate Health Plan",
      "customerName": "Amit Kumar",
      "claimNo": "CLM-2024-001236",
      "status": "Rejected",
      "amount": 28000,
      "date": "20-01-2024",
      "hospital": "Max Healthcare",
    },
    {
      "policyName": "Senior Citizen Care",
      "customerName": "Suresh Menon",
      "claimNo": "CLM-2024-001237",
      "status": "Settled",
      "amount": 67000,
      "date": "22-01-2024",
      "hospital": "Manipal Hospital",
    },
    {
      "policyName": "Critical Illness Cover",
      "customerName": "Neha Gupta",
      "claimNo": "CLM-2024-001238",
      "status": "In Progress",
      "amount": 125000,
      "date": "25-01-2024",
      "hospital": "Artemis Hospital",
    },
    {
      "policyName": "Basic Health Insurance",
      "customerName": "Vikram Singh",
      "claimNo": "CLM-2024-001239",
      "status": "Under Process",
      "amount": 15000,
      "date": "28-01-2024",
      "hospital": "Columbia Asia",
    },
    {
      "policyName": "Comprehensive Health Plan",
      "customerName": "Anjali Desai",
      "claimNo": "CLM-2024-001240",
      "status": "Settled",
      "amount": 89000,
      "date": "18-02-2024",
      "hospital": "Narayana Health",
    },
    {
      "policyName": "Group Health Policy",
      "customerName": "Rajesh Iyer",
      "claimNo": "CLM-2024-001241",
      "status": "Rejected",
      "amount": 42000,
      "date": "25-02-2024",
      "hospital": "Kokilaben Hospital",
    },
    {
      "policyName": "Individual Health Guard",
      "customerName": "Meera Nair",
      "claimNo": "CLM-2024-001242",
      "status": "In Progress",
      "amount": 55000,
      "date": "28-01-2024",
      "hospital": "Lilavati Hospital",
    },
    {
      "policyName": "Top-up Health Cover",
      "customerName": "Sanjay Reddy",
      "claimNo": "CLM-2024-001243",
      "status": "Settled",
      "amount": 35000,
      "date": "22-03-2024",
      "hospital": "Global Hospital",
    },
  ];
  String? selectedStatus;

  Widget statusClaimItem({
    required String title,
    required String description,
    required bool isCompleted,
    bool isCurrent = false,
    bool hasBadge = false,
    String badgeText = "",
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppTextTheme.primaryColor
                    : isCurrent
                    ? AppTextTheme.primaryColor
                    : Colors.orange[300],
                border: isCurrent
                    ? Border.all(color: AppTextTheme.primaryColor, width: 2)
                    : null,
              ),
              child: isCompleted
                  ? Icon(Icons.check, color: Colors.white, size: 16)
                  : Icon(Icons.warning, color: Colors.white, size: 16),
            ),

            if (!isCurrent)
              Container(
                width: 2,
                height: 80,
                color: isCompleted
                    ? AppTextTheme.primaryColor
                    : Colors.orange[300],
              ),
          ],
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCurrent ? AppTextTheme.primaryColor : Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),

              if (hasBadge && badgeText.isNotEmpty) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppTextTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppTextTheme.primaryColor),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppTextTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String selectedFilter = '';

  final List<String> _filters = [
    'GMC - 2',
    'Parent - 6',
    'Stakeholder - 8',
    'In Law - 6',
  ];
  @override
  bool get wantKeepAlive => true; // 👈 Prevents dispose() during tab switching

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Claim history",
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 60, // ⬅️ Increased height for shadow visibility
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
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
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: healthClaims.length,
                itemBuilder: (context, index) {
                  final claim = healthClaims[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 6,
                    ),
                    decoration: index == 0
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
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
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: const Color(0xFF56B3AD),
                              width: 1,
                            ),
                          ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          claim['policyName'],
                                          style: AppTextTheme.paragraph,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          claim['customerName'],
                                          style: AppTextTheme.subTitle,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Column(
                                    children: [
                                      Text(
                                        "Status",
                                        style: AppTextTheme.subItemTitle,
                                      ),
                                      const SizedBox(height: 2),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: _getStatusColor(
                                            claim['status'],
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 6,
                                          ),
                                          child: Text(
                                            claim['status'],
                                            style: AppTextTheme.paragraph
                                                .copyWith(
                                                  color: Colors.white,
                                                  // color: _getStatusColor(
                                                  //   claim['status'],
                                                  // ),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xffD8E9F1,
                                        ).withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Claim No: ${claim['claimNo']}",
                                          textAlign: TextAlign.center,
                                          style: AppTextTheme.paragraph
                                              .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff00635F),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xffD8E9F1,
                                        ).withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Created On: ${claim['date']}",
                                          textAlign: TextAlign.center,

                                          style: AppTextTheme.paragraph
                                              .copyWith(
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff00635F),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffD8E9F1).withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        "Flexi Floater Group Mediclaim Policy",
                                        textAlign: TextAlign.center,
                                        style: AppTextTheme.paragraph.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff00635F),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // Buttons row
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  height: 45,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF00B3AC),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _getStatusColor(String status) {
  switch (status) {
    case 'Under Process':
      return const Color(0xFFF0C21F); // Yellow
    case 'Settled':
      return const Color(0xFF3BCF85); // Green
    case 'Rejected':
      return const Color(0xFFFF4242); // Red
    case 'In Progress':
      return const Color(0xFF826E5D); // Brownish
    case 'Query':
      return const Color(0xFFF0901F); // Orange
    default:
      return Colors.grey;
  }
}
