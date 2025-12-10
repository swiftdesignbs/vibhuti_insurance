import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card_two.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/policy_benefit_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController relation = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController doc = TextEditingController();
  TextEditingController ocupation = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  final controllers = Get.put(StateController());

  Future<String?> _showCalenderBottomSheet(
    BuildContext context,
    TextEditingController textEditingController,
  ) async {
    return showModalBottomSheet(
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

  void _showOccupationBottomSheet(
    BuildContext context,
    TextEditingController controller,
  ) {
    final List<String> occupations = [
      "Software Engineer",
      "Doctor",
      "Teacher",
      "Business Owner",
      "Accountant",
      "Architect",
      "Civil Engineer",
      "Designer",
      "Electrician",
      "Lawyer",
      "Nurse",
      "Pharmacist",
      "Pilot",
      "Police Officer",
      "Sales Executive",
      "Student",
      "Unemployed",
      "Other",
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
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
                      const Text(
                        "Select Occupation",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: occupations.length,
                      itemBuilder: (context, index) {
                        final occupation = occupations[index];
                        return ListTile(
                          title: Text(occupation),
                          onTap: () {
                            controller.text = occupation;

                            Navigator.pop(context);
                          },
                        );
                      },
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

  void _showRelationBottomSheet(
    BuildContext context,
    TextEditingController controller,
  ) {
    final List<String> relations = [
      "Mother",
      "Father",
      "Son",
      "Daughter",
      "Sister",
      "Brother",
      "Other",
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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
              alignment: AlignmentGeometry.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.5,
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
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Select Relation",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount: relations.length,
                            itemBuilder: (context, index) {
                              final relation = relations[index];
                              return ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 0,
                                ), // No bottom padding
                                title: Text(
                                  relation,
                                  style: AppTextTheme.subItemTitle,
                                ),
                                onTap: () {
                                  controller.text = relation;
                                  Navigator.pop(context);
                                },
                              );

                              // return InkWell(
                              //   onTap: () {
                              //     controller.text = relation;

                              //     Navigator.pop(context);
                              //   },
                              //   child: Text(
                              //       relation,
                              //       style: AppTextTheme.subTitle,
                              //     ),
                              // );
                            },
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

  void _showAddDependentBottomSheet(BuildContext context) {
    showModalBottomSheet(
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
              alignment: AlignmentGeometry.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.80,
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
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                        SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Add Dependent',
                              style: AppTextTheme.pageTitle,
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Personal Details',
                                    style: AppTextTheme.pageTitle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFieldWithName(
                                    keyboardType: TextInputType.text,
                                    controller: name,
                                    hintText: "Text",
                                    ddName: 'Name',
                                  ),
                                  CustomTextFieldWithName(
                                    controller: relation,
                                    hintText: "Text",
                                    ddName: 'Relation',
                                    suffixIcon: "assets/icons/down_icon.svg",
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                      _showRelationBottomSheet(
                                        context,
                                        relation,
                                      );
                                    },
                                    readOnly: true,
                                  ),

                                  CustomTextFieldWithName(
                                    controller: dob,
                                    hintText: "DD/MM/YYYY",
                                    ddName: 'Date of Birth',
                                    readOnly: true,
                                    suffixIcon: "assets/icons/calender.svg",
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();

                                      final pickedDate =
                                          await _showCalenderBottomSheet(
                                            context,
                                            dob,
                                          );

                                      if (pickedDate != null) {
                                        setState(() {
                                          dob.text =
                                              pickedDate; // <-- PUT DATE IN TEXTFIELD
                                        });
                                      }
                                    },
                                  ),

                                  CustomTextFieldWithName(
                                    readOnly: true,
                                    controller: doc,
                                    hintText: "DD/MM/YYYY",
                                    ddName: 'Date of Coverage',
                                    suffixIcon: "assets/icons/calender.svg",
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();

                                      final pickedDate =
                                          await _showCalenderBottomSheet(
                                            context,
                                            doc,
                                          );

                                      if (pickedDate != null) {
                                        setState(() {
                                          doc.text =
                                              pickedDate; // <-- PUT DATE IN TEXTFIELD
                                        });
                                      }
                                    },
                                  ),

                                  CustomTextFieldWithName(
                                    controller: ocupation,
                                    hintText: "Select Occupation",
                                    ddName: 'Occupation',
                                    readOnly: true,
                                    suffixIcon: "assets/icons/down_icon.svg",
                                    onTap: () {
                                      _showOccupationBottomSheet(
                                        context,
                                        ocupation,
                                      );
                                    },
                                  ),

                                  Text(
                                    'Contact Details',
                                    style: AppTextTheme.pageTitle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  CustomTextFieldWithName(
                                    keyboardType: TextInputType.emailAddress,

                                    controller: emailId,
                                    hintText: "user@email.com",
                                    ddName: 'Email ID',
                                  ),
                                  CustomTextFieldWithName(
                                    keyboardType: TextInputType.phone,

                                    controller: mobileNo,
                                    hintText: "+91 98765 43210",
                                    ddName: 'Mobile No.',
                                  ),

                                  Text(
                                    'Add Documents',
                                    style: AppTextTheme.pageTitle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  DottedBorder(
                                    options: RoundedRectDottedBorderOptions(
                                      radius: Radius.circular(12),
                                      strokeWidth: 2,
                                      dashPattern: [6, 4],
                                      color: AppTextTheme.primaryColor,
                                    ),
                                    child: Container(
                                      height: 150,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF00B3Ac,
                                        ).withOpacity(0.10),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/upload_icon.svg',
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            'Tap to upload documents',
                                            style: AppTextTheme.subItemTitle
                                                .copyWith(
                                                  color:
                                                      AppTextTheme.primaryColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                  DottedBorder(
                                    options: RoundedRectDottedBorderOptions(
                                      radius: Radius.circular(50),
                                      strokeWidth: 2,
                                      dashPattern: [6, 4],
                                      color: AppTextTheme.primaryColor,
                                    ),
                                    child: Container(
                                      width: double.infinity,
                                      height: 45,
                                      decoration: BoxDecoration(
                                        color: Color(
                                          0xFF00B3Ac,
                                        ).withOpacity(0.10),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/fav_icon.svg',
                                              color: AppTextTheme.primaryColor,
                                              width: 24,
                                              height: 24,
                                            ),

                                            Center(
                                              child: Text(
                                                'FAQ Document',
                                                style: AppTextTheme.subTitle
                                                    .copyWith(
                                                      color: AppTextTheme
                                                          .primaryColor,
                                                    ),
                                              ),
                                            ),
                                            SvgPicture.asset(
                                              'assets/icons/trash.svg',
                                              width: 24,
                                              height: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Center(
                                    child: Buttons(
                                      onPressed: () {},
                                      ddName: "Save",
                                      width: 360,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
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

  @override
  void initState() {
    super.initState();
    print("controllers token :  ${controllers.authToken.toString()}");
    print("controllers user date :  ${controllers.authUser.toString()}");
    print(
      "controllers user date :  ${controllers.authUserProfileData.toString()}",
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadDependentData();
    });
  }

  //{"Action":"GetDependentInformation","EmployeeID":"108627"}

  List dependentDataList = [];
  Future<List?> getDependentData() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing getDependentData → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return null;
    }
    const url = "$baseUrl/api/BCGModule/GetAllProfileEmployeeDetails";
    final body = {
      "EmployeeID": controllers.authUser['employeeId'].toString(),
      //   "EmployeeID": 109015,
      "Action": "GetAllEmpProfileDataFOrHealthCard",
      //  "CompanyId": 204,
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };
    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );
      print("response : $response");
      if (response == null) return null;
      if (response["IsError"] == true) return null;
      return response["Result"] as List?; // <-- IMPORTANT
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  bool isLoading = false;
  List<String> stateList = [];
  String selectedState = "";
  List<Map<String, String>> familyMembers = [];

  Future<void> loadDependentData() async {
    setState(() => isLoading = true);

    final data = await getDependentData();
    print("data : $data");
    if (data != null) {
      familyMembers = data.map<Map<String, String>>((item) {
        return {
          "name": item["DependentName"]?.toString() ?? "NA",
          "dob": item["DateOfBirth"]?.toString() ?? "NA",
          "dependent": item["CategoryValue"]?.toString() ?? "NA", // STATIC
          "doc": item["DateOfJoining"]?.toString() ?? "NA", // STATIC
        };
      }).toList();
    } else {
      familyMembers = [];
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Profile", style: AppTextTheme.pageTitle),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Personal Details",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/icons/edit_icon.svg',
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              SizedBox(height: 10),
              employeeInfoCard(context, controllers),

              SizedBox(height: 10),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : familyMembers.isEmpty
                  ? Center(
                      child: Text(
                        "No dependents found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: familyMembers.length,
                      itemBuilder: (context, index) {
                        final member = familyMembers[index];
                        return FamilyCardTwo(
                          name: member['name']!,
                          dob: member['dob']!,
                          dependent: member['dependent']!, // STATIC NA
                          doc: member['doc']!, // STATIC NA
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

String _formatName(dynamic name) {
  if (name == null) return "";

  String text = name.toString().trim().toLowerCase();

  return text
      .split(" ")
      .map(
        (word) => word.isEmpty ? "" : word[0].toUpperCase() + word.substring(1),
      )
      .join(" ");
}

Widget employeeInfoCard(BuildContext context, StateController controllers) {
  final screenWidth = MediaQuery.of(context).size.width;
  final isSmallScreen = screenWidth < 360;
  // Extract data from the controller
  final profile = controllers.authUserProfileData;
  final items = [
    {"title": "Company Name", "description": profile["companyName"] ?? ""},
    {"title": "Employee Code", "description": profile["employeeCode"] ?? ""},
    {"title": "DOB", "description": profile["dateOfBirth"] ?? ""},
    {"title": "Gender", "description": profile["genderName"] ?? ""},
    {"title": "Email ID", "description": profile["emailAddress"] ?? ""},
    {"title": "Mobile No.", "description": profile["mobileNo"] ?? ""},
  ];
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),

      border: Border.all(color: const Color(0xFF56B3AD), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: AppTextTheme.primaryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            _formatName(profile["employeeName"]),
            style: AppTextTheme.buttonText.copyWith(
              fontSize: isSmallScreen ? 14 : 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisExtent: 60,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return FeatureItem2(
                    title: item["title"]!,
                    description: item["description"]!,
                  );
                },
              );
            },
          ),
        ),
      ],
    ),
  );
}

class FeatureItem2 extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem2({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: AppTextTheme.subTitle.copyWith(
              color: const Color(0xFF004370),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),

          Text(
            description,
            softWrap: true,
            maxLines: 2,
            style: AppTextTheme.subTitle.copyWith(
              color: const Color(0xFF004370),
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
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
