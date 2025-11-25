import 'dart:ui';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/admin_claim_history.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/booking_list_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/client_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/employee_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';

class AdminDashboardScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const AdminDashboardScreen({super.key, this.scaffoldKey});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> companyKey = GlobalKey();
  var companyController = TextEditingController();

  TextEditingController searchController = TextEditingController();
  List<String> filteredCompanies = [];

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Employee', 'screen': EmployeeScreen(), 'count': "00"},
    {'title': 'Client', 'screen': AdminClientScreen(), 'count': "00"},
    {
      'title': 'Booking List',

      'screen': AdminBookingListScreen(),
      'count': "00",
    },
    {'title': 'Claim History', 'screen': AdminClaimHistory(), 'count': "00"},
    {'title': 'Logout', 'screen': 'logout', 'count': ""},
  ];
  bool isDropdownOpen = false;
  String? selectedCompany;

  List<String> employeeList = [
    "Akshay Bisu",
    "Kalyani Sharma",
    "Rahul Verma",
    "Sneha Patil",
    "Rohit Deshmukh",
    "Priya Nair",
    "Amit Kulkarni",
    "Neha Gupta",
    "Sagar Joshi",
    "Megha Iyer",
    "Vikas Mehta",
    "Pooja Shetty",
    "Karan Malhotra",
  ];

  List<String> filteredList = [];
  bool showDropdown = false;

  void _showHealthCardBottomSheet() {
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
                heightFactor: 0.50,
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
                  padding: const EdgeInsets.all(20),
                  child: Column(
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
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Health Card Quick View',
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Employee Name',
                              style: AppTextTheme.subItemTitle,
                            ),
                            Text(
                              'Company Name',
                              style: AppTextTheme.subItemTitle,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sagar Joshi\nVIBPL-009',
                              style: AppTextTheme.subTitle,
                            ),
                            Text(
                              'Vibhuti Insurance',
                              style: AppTextTheme.subTitle,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
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
                                          "Sum Insured",
                                          style: AppTextTheme.paragraph,
                                        ),
                                        Text(
                                          "2000000",
                                          style: AppTextTheme.subTitle.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),

                                        const SizedBox(height: 5),

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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Covers",
                                            style: AppTextTheme.paragraph,
                                          ),
                                          Text(
                                            "Health Accident",
                                            style: AppTextTheme.subTitle
                                                .copyWith(fontSize: 12),
                                          ),
                                          const SizedBox(height: 10),

                                          Text(
                                            "End Date",
                                            style: AppTextTheme.paragraph,
                                          ),
                                          Text(
                                            "14-Feb-2025",
                                            style: AppTextTheme.subTitle
                                                .copyWith(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 5),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "TPA",
                                  style: AppTextTheme.paragraph,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "Vidal Health Insurance Pvt Ltd",
                                  style: AppTextTheme.subTitle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Add your health card form fields here
                    ],
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
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(
            'assets/icons/menu.svg',
            height: 16,
            width: 16,
          ),
        ),
        backgroundColor: AppTextTheme.appBarColor,
        title: Text(
          "Welcome Aarti",
          style: AppTextTheme.paragraph.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {},
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
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: menuItems.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final bool isLogout = item['screen'] == 'logout';

                return InkWell(
                  onTap: () {
                    if (isLogout) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => LoginSelection()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => item['screen']),
                      );
                    }
                  },

                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    decoration: index == 0
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppTextTheme.primaryColor,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(3, 4),
                                blurRadius: 0,
                                spreadRadius: 1,
                              ),
                            ],
                          )
                        : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color(0xFF00635F),
                              width: 1.5,
                            ),
                          ),
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF44B6AE),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF00635F),
                                offset: Offset(3, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: isLogout
                                ? SvgPicture.asset(
                                    "assets/icons/logout_icon.svg",
                                    color: Colors.white,
                                  )
                                : Text(
                                    item['count'] ?? "00",
                                    style: AppTextTheme.subItemTitle.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            item['title'],
                            style: AppTextTheme.subTitle.copyWith(
                              fontSize: 18,
                              color: index == 0
                                  ? AppTextTheme.primaryColor
                                  : Color(0xFF00635F),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
            const Text("Health Card Quick View", style: AppTextTheme.subTitle),
            const SizedBox(height: 15),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔍 SEARCH INPUT BOX
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: AppTextTheme.primaryColor,
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(2, 3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        filteredList = employeeList
                            .where(
                              (item) => item.toLowerCase().contains(
                                value.toLowerCase(),
                              ),
                            )
                            .toList();

                        showDropdown = value.isNotEmpty;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search company...",
                      border: InputBorder.none, // normal state
                      enabledBorder: InputBorder.none, // enabled state
                      focusedBorder: InputBorder.none, // when typing
                      disabledBorder: InputBorder.none, // disabled state
                      errorBorder: InputBorder.none, // error state
                      focusedErrorBorder: InputBorder.none, // focused error
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      suffixIcon: Icon(Icons.search, color: Colors.teal),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // 🔽 SUGGESTION BOX
                if (showDropdown)
                  Container(
                    height: 260,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppTextTheme.primaryColor,
                        width: 1,
                      ),
                    ),
                    child: ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        final item = filteredList[index];

                        return InkWell(
                          onTap: () {
                            setState(() {
                              searchController.text = item;
                              showDropdown = false;
                            });

                            _showHealthCardBottomSheet();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item,
                                  style: AppTextTheme.paragraph.copyWith(
                                    fontSize: 14,
                                  ),
                                ),

                                Divider(
                                  color: Colors.grey.shade300,
                                  thickness: 1,
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
          ],
        ),
      ),
    );
  }
}
