import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/shadow_btn.dart';

class BookingScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const BookingScreen({super.key, this.scaffoldKey});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController appointmentDate1Controller = TextEditingController();
  TextEditingController appointmentDate2Controller = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  TextEditingController remarksController2 = TextEditingController();

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
      "checkup_name": "Health Checkup",
      "package_cost": "₹ 7999",
      "created_on": "2024-01-20",
      "package_name": "Platinum Health Plan",
    },
    {
      "name": "Sarah Johnson",
      "checkup_name": "Cardiac Checkup",
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
      "checkup_name": "Health Check",
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
      "checkup_name": "Basic Diagnostic",
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

  Future<String?> _showCalenderBottomSheet(
    BuildContext context,
    TextEditingController textEditingController,
  ) async {
    return showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.8 : 0.95;

        int selectedYear = DateTime.now().year;
        int selectedTab = 0; // 0 = Calendar, 1 = Filter

        List<int> years = List.generate(25, (i) => DateTime.now().year - i);

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
                                      ddName: "Calendar",
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
                                      ddName: "Filter",
                                      width: double.infinity,
                                      isActive: selectedTab == 1,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Expanded(
                                child: selectedTab == 0
                                    ? _calendarView(context, (value) {
                                        Navigator.pop(
                                          context,
                                          value,
                                        ); // Pop correctly
                                      })
                                    : _filterView(years, selectedYear, (year) {
                                        setState(() => selectedYear = year);
                                      }),
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

  void _showPackageDetailsBottomSheet(
    BuildContext context,
    Map<String, dynamic> package,
  ) {
    showModalBottomSheet(
      useRootNavigator: true,
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
                      // bottomLeft: Radius.circular(20),
                      // bottomRight: Radius.circular(20),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Booking Details',
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
                                detailRow('Employee Name', "Rajesh Kumar"),
                                detailRow(
                                  'Email ID',
                                  "rajesh.kumar@company.com",
                                ),
                                detailRow('Mobile No.', "+91 98765 43210"),
                                detailRow('Patient Name', "Priya Sharma"),
                                detailRow('Relation', "Daughter"),
                                detailRow('Age', "12 Years"),
                                detailRow('Gender', "Female"),
                                detailRow(
                                  'Selected Plan',
                                  "Gold Health Plan - Family",
                                ),
                                detailRow(
                                  'Appointment Date 1',
                                  "15 March 2024",
                                ),
                                detailRow(
                                  'Appointment Date 2',
                                  "22 March 2024",
                                ),
                                detailRow('Hospital Name', "Apollo Hospitals"),
                                detailRow(
                                  'Hospital Address',
                                  "Sector 23, DLF Phase 3, Gurugram",
                                ),
                                SizedBox(height: 20),

                                detailRow('State', "Haryana"),
                                detailRow('City', "Gurugram"),
                                detailRow('Pincode', "122002"),
                                detailRow('Status', "Confirmed"),
                                detailRow('Booking Date', "10 March 2024"),
                                detailRow('Booking Time', "02:30 PM"),

                                SizedBox(height: 10),
                                Text(
                                  "Remarks",
                                  style: AppTextTheme.paragraph.copyWith(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "Reschedule By Admin",
                                  style: AppTextTheme.paragraph.copyWith(
                                    color: Colors.red,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 20),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Buttons(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                      await Future.delayed(
                                        const Duration(milliseconds: 200),
                                      );
                                      _showCancelBottomSheet(context);
                                    },
                                    ddName: "Booking Cancellation",

                                    width: double.infinity,
                                  ),
                                ),

                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        await Future.delayed(
                                          const Duration(milliseconds: 200),
                                        );
                                        _showRescheduleBottomSheet(
                                          context,
                                          package,
                                        );
                                      },

                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            50,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Reschedule",
                                        style: AppTextTheme.buttonText.copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: AppTextTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
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

  void _showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (sheetContext) {
        final mediaQuery = MediaQuery.of(sheetContext);
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
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: mediaQuery.viewInsets.bottom + 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                        SizedBox(height: 10),
                        Text('Success !', style: AppTextTheme.pageTitle),
                        const SizedBox(height: 20),
                        Text(
                          'Successfully Updated !',
                          style: AppTextTheme.subTitle,
                        ),
                        const SizedBox(height: 30),
                        Buttons(
                          onPressed: () => Navigator.pop(sheetContext),
                          ddName: "Okay",

                          width: double.infinity,
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

  void _showCancelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (sheetContext) {
        final mediaQuery = MediaQuery.of(sheetContext);
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
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: mediaQuery.viewInsets.bottom + 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Cancel Appointment',
                              style: AppTextTheme.pageTitle,
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(sheetContext),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Text("Remarks", style: AppTextTheme.subItemTitle),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: remarksController2,
                          hintText: "Text",
                        ),

                        Buttons(
                          onPressed: () => Navigator.pop(sheetContext),
                          ddName: "Submit",

                          width: double.infinity,
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                "Reschedule",
                                style: AppTextTheme.buttonText.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTextTheme.primaryColor,
                                ),
                              ),
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

  void _showRescheduleBottomSheet(
    BuildContext context,
    Map<String, dynamic> package,
  ) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
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
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reschedule Appointment',
                              style: AppTextTheme.pageTitle,
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Text(
                          "New Appointment Date 1",
                          style: AppTextTheme.subItemTitle,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          readOnly: true,
                          controller: appointmentDate1Controller,
                          hintText: "DD/MM/YYYY",
                          suffixIcon: "assets/icons/calender.svg",
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            final pickedDate = await _showCalenderBottomSheet(
                              context,
                              appointmentDate1Controller,
                            );

                            if (pickedDate != null) {
                              setState(() {
                                appointmentDate1Controller.text =
                                    pickedDate; // <-- PUT DATE IN TEXTFIELD
                              });
                            }
                          },
                        ),

                        Text(
                          "New Appointment Date 2",
                          style: AppTextTheme.subItemTitle,
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          readOnly: true,
                          controller: appointmentDate2Controller,
                          hintText: "DD/MM/YYYY",
                          suffixIcon: "assets/icons/calender.svg",
                          onTap: () async {
                            FocusScope.of(context).unfocus();

                            final pickedDate = await _showCalenderBottomSheet(
                              context,
                              appointmentDate2Controller,
                            );

                            if (pickedDate != null) {
                              setState(() {
                                appointmentDate2Controller.text =
                                    pickedDate; // <-- PUT DATE IN TEXTFIELD
                              });
                            }
                          },
                        ),

                        Text("Remarks", style: AppTextTheme.subItemTitle),
                        const SizedBox(height: 8),
                        CustomTextField(
                          controller: remarkController,
                          hintText: "Text",
                        ),
                        const SizedBox(height: 30),

                        Buttons(
                          onPressed: () async {
                            Navigator.pop(context);
                            await Future.delayed(
                              const Duration(milliseconds: 200),
                            );
                            _showSuccessBottomSheet(context);
                          },
                          ddName: "Submit",

                          width: double.infinity,
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
        screenTitle: "Booking List",
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
            SizedBox(height: 20),
            CustomTextField(
              controller: searchController,
              hintText: "Search",
              suffixIcon: "assets/icons/search_color.svg",
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: insurancePackages.length,
                itemBuilder: (context, index) {
                  final package = insurancePackages[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Package Cost",
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                      'Created: ${package['created_on']}',
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
                                    //#D8E9F180
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
                              ],
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              _showPackageDetailsBottomSheet(context, package);
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

Widget _calendarView(BuildContext context, Function(String) onSelectDate) {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  return StatefulBuilder(
    builder: (context, setState) {
      return TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime(1900),
        lastDay: DateTime(2900),

        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: AppTextTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          todayTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppTextTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });

          final formattedDate =
              "${selectedDay.day.toString().padLeft(2, '0')}/"
              "${selectedDay.month.toString().padLeft(2, '0')}/"
              "${selectedDay.year}";

          onSelectDate(formattedDate); // 🔥 Return selected date
        },
      );
    },
  );
}

/// FILTER TAB — YEAR LIST WITH RADIO BUTTONS
Widget _filterView(List<int> years, int selectedYear, Function(int) onSelect) {
  return ListView.builder(
    itemCount: years.length,
    itemBuilder: (context, index) {
      return InkWell(
        onTap: () {
          onSelect(years[index]);

          Navigator.pop(
            context,
            "01/01/${years[index]}",
          ); // <-- RETURN DATE FIX
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(years[index].toString(), style: TextStyle(fontSize: 18)),
        ),
      );
    },
  );
}
