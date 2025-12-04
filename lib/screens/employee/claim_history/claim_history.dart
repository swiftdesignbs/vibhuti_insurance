import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/claim_history/claim_history_pt.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/health_claims/create_claim/claims_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/claim_status_widget.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class ClaimHistoryScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const ClaimHistoryScreen({super.key, required this.scaffoldKey});

  @override
  State<ClaimHistoryScreen> createState() => _ClaimHistoryScreenState();
}

class _ClaimHistoryScreenState extends State<ClaimHistoryScreen>
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
      "status": "Settled",
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

  void _showCalenderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.7 : 0.80;

        int selectedTab = 0; // 0 = Year-Year, 1 = Status

        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(color: Colors.black.withOpacity(0.1)),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: sheetHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            children: [
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
                              SizedBox(height: 20),

                              /// ------------------ TAB BUTTONS -------------------
                              Row(
                                children: [
                                  Expanded(
                                    child: FilterButtons(
                                      onPressed: () {
                                        setState(() => selectedTab = 0);
                                      },
                                      ddName: "Year - Year",
                                      width: double.infinity,
                                      isActive: selectedTab == 0,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: FilterButtons(
                                      onPressed: () {
                                        setState(() => selectedTab = 1);
                                      },
                                      ddName: "Status",
                                      width: double.infinity,
                                      isActive: selectedTab == 1,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),

                              /// ------------------ TAB CONTENT -------------------
                              Expanded(
                                child: selectedTab == 0
                                    ? _yearFilterView()
                                    : _statusFilterView(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // SizedBox(height: 10),

            // Row(
            //   children: [
            //     Expanded(
            //       child: GestureDetector(
            //         onTap: () => _showCalenderBottomSheet(context),
            //         child: AbsorbPointer(
            //           child: CustomTextField(
            //             controller: dateController,
            //             hintText: "Select Date",
            //             suffixIcon: "assets/icons/calender.svg",
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),

            // SizedBox(height: 10),
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

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: CustomTextField(
                    controller: searchController,
                    hintText: "Search",
                    suffixIcon: "assets/icons/search_color.svg",
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
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
                  ),
                  width: 46,
                  height: 46,
                  child: CircleAvatar(
                    backgroundColor: AppTextTheme.primaryColor,
                    child: IconButton(
                      onPressed: () {
                        _showCalenderBottomSheet(context);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/filters.svg",
                        height: 20,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),

            if (selectedStatus != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xffE6F6F6),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Color(0xff00635F)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        selectedStatus!,
                        style: TextStyle(
                          color: Color(0xff00635F),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStatus = null; // Remove filter
                          });
                        },
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xff00635F),
                        ),
                      ),
                    ],
                  ),
                ),
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
                    decoration: BoxDecoration(
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
                            ],
                          ),
                        ),

                        // Buttons row
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ClaimHistoryPt1(),
                                    ),
                                  );
                                },
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

// Widget bulletPoints(String text) {
//   return Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text("•  ", style: TextStyle(fontSize: 16, height: 1.4)),
//         Expanded(
//           child: Text(
//             text,
//             style: AppTextTheme.paragraph.copyWith(
//               color: Colors.black87,
//               //  height: 1.4,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

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
    default:
      return Colors.grey;
  }
}

Widget _yearFilterView() {
  final List<String> yearList = [
    "2019 - 2020",
    "2020 - 2021",
    "2021 - 2022",
    "2022 - 2023",
    "2023 - 2024",
  ];

  String? selectedYear;

  return StatefulBuilder(
    builder: (context, setState) {
      return ListView.builder(
        itemCount: yearList.length,
        itemBuilder: (context, index) {
          return RadioListTile<String>(
            title: Text(
              yearList[index],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            value: yearList[index],
            groupValue: selectedYear,
            onChanged: (value) {
              setState(() => selectedYear = value);
              Navigator.pop(context, value);
            },
          );
        },
      );
    },
  );
}

Widget _statusFilterView() {
  final List<String> statusList = [
    "Query",
    "Under Process",
    "Approved",
    "Settledd",
    "Cancelled",
    "Recycled",
    "In Progress",
  ];

  String? selectedStatus;

  return StatefulBuilder(
    builder: (context, setState) {
      return ListView.builder(
        itemCount: statusList.length,
        itemBuilder: (context, index) {
          return RadioListTile<String>(
            title: Text(
              statusList[index],
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            value: statusList[index],
            groupValue: selectedStatus,
            onChanged: (value) {
              setState(() => selectedStatus = value);
              Navigator.pop(context, value);
            },
          );
        },
      );
    },
  );
}
