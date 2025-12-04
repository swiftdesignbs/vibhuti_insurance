import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/dental/dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/home_sample.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/opd_benefits.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/vision/vision_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/policy_benefit_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/quick_links.dart';
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
  final controllers = Get.put(StateController());

  Future<String> getDownloadFolderPath() async {
    final dir =
        await getExternalStorageDirectory(); // /storage/emulated/0/Android/data/<package>/files
    final downloadPath = "/storage/emulated/0/Download";

    return downloadPath;
  }

  final List<Map<String, dynamic>> carouselIcons = [
    {
      "icon": "assets/icons/wellness_8.svg",
      "label": "Health Checkup",
      "route": HealthCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_1.svg",
      "label": "Home Sample Collection",
      "route": HomeSampleScreen(),
    },
    {
      "icon": "assets/icons/wellness_5.svg",
      "label": "Dental Checkup",
      "route": DentalCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_4.svg",
      "label": "Vision Checkup",
      "route": VisionCheckUpScreen(),
    },
    {
      "icon": "assets/icons/wellness_3.svg",
      "label": "OPD Benefits",
      "route": OPDBenefitsScreen(),
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

  void _showDependentBottomSheet(
    BuildContext context,
    List<dynamic> dependentDataList,
  ) {
    showModalBottomSheet(
      useRootNavigator: true,
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
                              children: List.generate(
                                dependentDataList.length,
                                (index) {
                                  final item = dependentDataList[index];
                                  return familyCard(
                                    context: context,
                                    iconPath: 'assets/icons/circle-user.svg',
                                    title: item['DependentName'] ?? 'N/A',
                                    subtitle:
                                        'DOB: ${item['DateOfBirth'] ?? 'N/A'}',
                                  );
                                },
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

  Map<String, dynamic>? selfPolicyData;
  bool isLoadingPolicy = false;
  List<dynamic>? allDependents;

  Future<Map<String, dynamic>?> getSelfPolicyData() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing in getSelfPolicyData → Redirecting to Login ");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
      return null;
    }

    print(
      " Starting getSelfPolicyData() : ${controllers.authToken.toString()}",
    );
    const url = "$baseUrl/api/BCGModule/GetAllProfileEmployeeDetails";

    final body = {
      "EmployeeID": controllers.authUser['employeeId'].toString(),
      "Action": "GetAllEmpProfileDataFOrHealthCard",
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    try {
      print(" Fetching Self Policy Data");
      print("➡ EmployeeID: ${controllers.authUser['employeeId']}");
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );
      if (response == null) {
        print(" API response is NULL");
        return null;
      }

      if (response["IsError"] == true) {
        print(" Server error: ${response["ErrorMessage"]}");
        return null;
      }

      final List result = response["Result"] ?? [];
      print("✅ Received ${result.length} items");

      // Debug: Print all categories
      for (var item in result) {
        print(
          "📝 Item - Category: ${item['CategoryValue']}, Name: ${item['DependentName']}",
        );
      }

      // Find the item with CategoryValue = "Self"
      final selfData = result.firstWhere(
        (item) => item['CategoryValue'] == 'Self',
        orElse: () => null,
      );

      if (selfData != null) {
        print("✅ Self data found!");
        print("➡ PolicyNo: ${selfData['PolicyNo']}");
        print("➡ SumInsured: ${selfData['SumInsured']}");
        print("➡ PolicyStartDate: ${selfData['PolicyStartDate']}");
        return selfData;
      } else {
        print(" No Self category found in response");
        return null;
      }
    } catch (e) {
      print(" Exception in getSelfPolicyData: $e");
      return null;
    }
  }

  List dependentDataList = [];

  Future<List?> getDependentData() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing  getDependentData → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return null;
    }
    const url = "$baseUrl/api/BCGModule/GetAllProfileEmployeeDetails";

    final body = {
      "EmployeeID": controllers.authUser['employeeId'].toString(),
      "Action": "GetAllEmpProfileDataFOrHealthCard",
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );

      if (response == null) return null;
      if (response["IsError"] == true) return null;

      return response["Result"] as List?; // <-- IMPORTANT
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSelfPolicyData();
    fetchDependentData();
  }

  Future<void> fetchDependentData() async {
    final data = await getDependentData(); // call your API function

    if (!mounted) return; // safety

    setState(() {
      dependentDataList = data ?? [];
    });
  }

  Future<void> fetchSelfPolicyData() async {
    if (isLoadingPolicy) return;

    setState(() {
      isLoadingPolicy = true;
    });

    try {
      final data = await getSelfPolicyData();
      setState(() {
        selfPolicyData = data;
      });
    } catch (e) {
      print("Error fetching policy data: $e");
    } finally {
      setState(() {
        isLoadingPolicy = false;
      });
    }
  }

  String _formatSumInsured(dynamic sumInsured) {
    if (sumInsured == null) return 'N/A';

    if (sumInsured is int || sumInsured is double) {
      // Format number with commas
      final formatter = NumberFormat('#,##0');
      return '₹ ${formatter.format(sumInsured)}';
    }

    if (sumInsured is String) {
      return '₹ $sumInsured';
    }

    return 'N/A';
  }

  Future<void> downloadManual(BuildContext context) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
      return;
    }
    print("🔽 downloadManual() called");

    try {
      // 1️⃣ API 1 - Get File Path
      print("📡 API 1 → Fetching manual path...");

      final url1 = "$baseUrl/api/BCGModule/GetALLClaimDetailsByClaimID";
      final body1 = {
        "CompanyID": controllers.authUserProfileData['companyId'].toString(),
        "Action": "DownloadUserManual",
      };

      final res1 = await ApiService.postRequest(
        url: url1,
        body: body1,
        token: token,
      );
      print("✅ API 1 Response: $res1");

      final manualPath = res1?["Result"]?[0]["Message"];
      print("📄 manualPath received → $manualPath");

      // 2️⃣ API 2 - Get Base64 PDF
      print("📡 API 2 → Fetching actual PDF Base64...");

      final url2 = "$baseUrl/api/Account/DownloadDocument";
      final body2 = {"File": manualPath};

      final res2 = await ApiService.postRequest(
        url: url2,
        body: body2,
        token: token,
      );
      print("✅ API 2 Response: $res2");

      final base64File = res2?["Result"]?["fileData"];

      if (base64File == null || base64File.isEmpty) {
        print("❌ ERROR: fileData is empty!");
        CustomToast.show(
          context: context,
          message: "Invalid file data",
          success: false,
        );
        return;
      }

      print("📄 Base64 file received!");

      // -------------------------------------------------
      // 3️⃣ Decode Base64 → Save PDF
      // -------------------------------------------------
      final bytes = base64Decode(base64File);

      // Save into Downloads folder (Android)
      final directory = Directory("/storage/emulated/0/Download");
      final filePath = "${directory.path}/UserManual.pdf";
      final file = File(filePath);

      await file.writeAsBytes(bytes);
      print("📁 PDF saved → $filePath");

      CustomToast.show(
        context: context,
        message: "File saved in Download folder",
        success: true,
      );

      //  OpenFile.open(filePath);
    } catch (e, stack) {
      print("❌ ERROR in downloadManual()");
      print("🔍 Exception: $e");
      print("📌 StackTrace:\n$stack");

      CustomToast.show(
        context: context,
        message: "Something went wrong",
        success: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Dashboard",
        userName: "${controllers.authUserProfileData['employeeName'] ?? ''}",
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

              isLoadingPolicy
                  ? Center(child: CircularProgressIndicator())
                  : selfPolicyData !=
                        null // ✅ CHANGED THIS CONDITION
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF56B3AD),
                          width: 1.2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
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
                                  topLeft: Radius.circular(18),
                                  topRight: Radius.circular(18),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  'Policy No: ${selfPolicyData?['PolicyNo'] ?? 'N/A'}',
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
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                        _formatSumInsured(
                                          selfPolicyData?['SumInsured'],
                                        ),
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
                                        selfPolicyData?['PolicyStartDate'] ??
                                            'N/A',
                                        style: AppTextTheme.subTitle.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 100),
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
                                          "Health Accident", // You can make this dynamic
                                          style: AppTextTheme.subTitle.copyWith(
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "End Date",
                                          style: AppTextTheme.paragraph,
                                        ),
                                        Text(
                                          selfPolicyData?['PolicyEndDate'] ??
                                              'N/A',
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text("TPA", style: AppTextTheme.paragraph),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                selfPolicyData?['TPAName'] ?? 'N/A',
                                style: AppTextTheme.subTitle.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        "NO POLICY CARD AVAILABLE",
                        style: AppTextTheme.subTitle.copyWith(fontSize: 12),
                      ),
                    ),
              const SizedBox(height: 20),
              if (dependentDataList.length > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Dependents",
                      style: AppTextTheme.subTitle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showDependentBottomSheet(context, dependentDataList);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero, // removes extra padding
                        minimumSize: Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "View More",
                            style: AppTextTheme.coloredSubTitle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 70,
                            color: AppTextTheme.primaryColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 10),
              // Wrap(
              //   spacing: 25, // horizontal space between cards
              //   // runSpacing: 5, // vertical space between rows
              //   children: [
              //     familyCard(
              //       context: context,
              //       iconPath: 'assets/icons/circle-user.svg',
              //       title: 'Kumar Sangakara',
              //       subtitle: 'DOB: 19-07-1987',
              //     ),
              //     familyCard(
              //       context: context,
              //       iconPath: 'assets/icons/circle-user.svg',
              //       title: 'Sachin Tendulkar',
              //       subtitle: 'DOB: 19-07-1987',
              //     ),
              //   ],
              // ),
              Row(
                children: [
                  if (dependentDataList.length > 0)
                    Expanded(
                      child: familyCard(
                        context: context,
                        iconPath: 'assets/icons/circle-user.svg',
                        title: dependentDataList[0]['DependentName'] ?? 'N/A',
                        subtitle:
                            'DOB: ${dependentDataList[0]['DateOfBirth'] ?? 'N/A'}',
                      ),
                    ),

                  SizedBox(width: 12),

                  if (dependentDataList.length > 1)
                    Expanded(
                      child: familyCard(
                        context: context,
                        iconPath: 'assets/icons/circle-user.svg',
                        title: dependentDataList[1]['DependentName'] ?? 'N/A',
                        subtitle:
                            'DOB: ${dependentDataList[1]['DateOfBirth'] ?? ''}',
                      ),
                    ),
                ],
              ),

              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Policy Benefits",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => MyPolicyScreen());
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero, // removes extra padding
                      minimumSize: Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "View Details",
                          style: AppTextTheme.coloredSubTitle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                        ),
                      ],
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

                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0XFF00635F), width: 1),
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

              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: carouselIcons.length,
                  itemBuilder: (context, index) {
                    final int targetIndex =
                        0; // Only this index will get the label above

                    return InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: carouselIcons[index]['route'],
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4.5,
                        child: Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            /// 🔵 Main column (circle + label below)
                            Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ), // space for above label
                                // Circle container
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppTextTheme.primaryColor,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: const Color(0xFFF6F7F9),
                                    child: SvgPicture.asset(
                                      carouselIcons[index]['icon'],
                                      color: Colors.black,
                                      height: 30,
                                      width: 30,
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 8),

                                // Bottom text
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

                            /// 🔺 The label ABOVE the circle
                            if (index == targetIndex)
                              Positioned(
                                bottom: 63,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppTextTheme.primaryColor,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    "Center Visit",
                                    style: AppTextTheme.subItemTitle.copyWith(
                                      // color: AppTextTheme.primaryColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8,
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
                      color: Color(0xFFBDECEB),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: Center(
                      child: Text(
                        nameList[index]['label']!,
                        textAlign: TextAlign.center,
                        style: AppTextTheme.subTitle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
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
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Quick Links",
                    style: AppTextTheme.subTitle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              ExpandableQuickLink(
                title: "Manual Guide",
                expandedContent: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Buttons(
                      onPressed: () {
                        downloadManual(context);
                      },
                      ddName: "Download user manual",
                      width: 150,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
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
