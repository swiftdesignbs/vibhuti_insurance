import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
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
      isScrollControlled:
          true, 
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                          
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Booking Details', style: AppTextTheme.pageTitle),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                          
                    detailRow('Employee Name', "Rajesh Kumar"),
                    detailRow('Email ID', "rajesh.kumar@company.com"),
                    detailRow('Mobile No.', "+91 98765 43210"),
                    detailRow('Patient Name', "Priya Sharma"),
                    detailRow('Relation', "Daughter"),
                    detailRow('Age', "12 Years"),
                    detailRow('Gender', "Female"),
                    detailRow('Selected Plan', "Gold Health Plan - Family"),
                    detailRow('Appointment Date 1', "15 March 2024"),
                    detailRow('Appointment Date 2', "22 March 2024"),
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
                          
                    //   ShadowBtn(btnName: "Booking Cancel", onTap: () {}),
                    Buttons(
                      onPressed: () {},
                      ddName: "Booking Cancel",
                      height: 50,
                      width: double.infinity,
                    ),
                          
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await Future.delayed(const Duration(milliseconds: 200));
                          _showRescheduleBottomSheet(context, package);
                        },
                          
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSuccessBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (sheetContext) {
        final mediaQuery = MediaQuery.of(sheetContext);
        return Container(
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
                  Text('Success !', style: AppTextTheme.pageTitle),
                  const SizedBox(height: 20),
                  Text('Successfully Updated !', style: AppTextTheme.subTitle),
                  const SizedBox(height: 30),
                  Buttons(
                    onPressed: () => Navigator.pop(sheetContext),
                    ddName: "Okay",
                    height: 50,
                    width: double.infinity,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showRescheduleBottomSheet(
    BuildContext context,
    Map<String, dynamic> package,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
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
                    controller: searchController,
                    hintText: "DD/MM/YYYY",
                    suffixIcon: FaIcon(
                      FontAwesomeIcons.calendarDays,
                      color: AppTextTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    "New Appointment Date 2",
                    style: AppTextTheme.subItemTitle,
                  ),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: searchController,
                    hintText: "DD/MM/YYYY",
                    suffixIcon: FaIcon(
                      FontAwesomeIcons.calendarDays,
                      color: AppTextTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text("Remarks", style: AppTextTheme.subItemTitle),
                  const SizedBox(height: 8),
                  CustomTextField(
                    controller: searchController,
                    hintText: "Text",
                  ),
                  const SizedBox(height: 30),

                  Buttons(
                    onPressed: () async {
                      Navigator.pop(context);
                      await Future.delayed(const Duration(milliseconds: 200));
                      _showSuccessBottomSheet(context);
                    },
                    ddName: "Submit",
                    height: 50,
                    width: double.infinity,
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
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Booking", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,

        leading: IconButton(
          onPressed: () {
            if (widget.scaffoldKey != null) {
              widget.scaffoldKey!.currentState?.openDrawer();
            } else {
              Scaffold.of(context).openDrawer();
            }
          },
          icon: Image.asset('assets/icons/menu.png', height: 24, width: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade200,
              child: Image.asset(
                'assets/icons/profile_icon.png',
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              CustomTextField(
                controller: searchController,
                hintText: "Search",
                suffixIcon: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: AppTextTheme.primaryColor,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Created: ${package['created_on']}',
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
                                    '${package['checkup_name']}',
                                    style: AppTextTheme.paragraph.copyWith(
                                      color: AppTextTheme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
