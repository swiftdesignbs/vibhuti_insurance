import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/utils/download_service.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/policy_benefit_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/shadow_btn.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';

class MyPolicyScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  //  final String? initialPolicyNo; // ← ADD THIS

  const MyPolicyScreen({
    super.key,
    this.scaffoldKey,
    // this.initialPolicyNo,
  }); // ← AND THIS

  @override
  State<MyPolicyScreen> createState() => _MyPolicyScreenState();
}

class _MyPolicyScreenState extends State<MyPolicyScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController appointmentDate1Controller = TextEditingController();
  TextEditingController appointmentDate2Controller = TextEditingController();
  final controllers = Get.put(StateController());

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

  void _showPackageDetailsBottomSheet(
    BuildContext context,
    String employeeId,
    String policyNo,
  ) {
    // Fetch profile details when bottom sheet opens
    Future<Map<String, dynamic>?> profileFuture = getProfileDetails(
      employeeId,
      policyNo,
    );

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.black.withOpacity(0.2),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FutureBuilder<Map<String, dynamic>?>(
          future: profileFuture,
          builder: (context, snapshot) {
            // Handle loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _buildBottomSheetLoading(context);
            }

            // Handle error state
            if (snapshot.hasError || snapshot.data == null) {
              return _buildBottomSheetError(context, employeeId, policyNo);
            }

            // Success state - display data
            final profileData = snapshot.data!;
            return _buildBottomSheetContent(
              context,
              employeeId,
              policyNo,
              profileData,
            );
          },
        );
      },
    );
  }

  // Loading state widget
  Widget _buildBottomSheetLoading(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(color: Colors.black.withOpacity(0.1)),
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
              ),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
        ),
      ],
    );
  }

  // Error state widget with retry option
  Widget _buildBottomSheetError(
    BuildContext context,
    String employeeId,
    String policyNo,
  ) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(color: Colors.black.withOpacity(0.1)),
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
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 50),
                  SizedBox(height: 16),
                  Text('Failed to load policy details'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _showPackageDetailsBottomSheet(
                        context,
                        employeeId,
                        policyNo,
                      );
                    },
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Main content widget with actual data
  Widget _buildBottomSheetContent(
    BuildContext context,
    String employeeId,
    String policyNo,
    Map<String, dynamic> profileData,
  ) {
    final insuranceCo = profileData['InsuranceCompany'] ?? 'N/A';
    final policyName = profileData['PolicyName'] ?? 'N/A';
    final policyNumber = profileData['PolicyNo'] ?? policyNo;
    final policyType = profileData['PolicyType'] ?? 'N/A';
    final policyStart = profileData['PolicyStartDate'] ?? 'N/A';
    final policyEnd = profileData['PolicyEndDate'] ?? 'N/A';
    final gender = profileData['Gender'] ?? 'N/A';
    final sumInsured = profileData['SumInsured'] ?? 'N/A';
    final healthCardNo = profileData['HealthCardNo'] ?? 'N/A';
    final dependentCount = profileData['NoOfDependents'] ?? '0';
    final healthCardPath = profileData['HealthCardPath']?.toString() ?? '';

    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Container(color: Colors.black.withOpacity(0.1)),
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
                        Text('Policy Details', style: AppTextTheme.pageTitle),
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

                            // Policy Details Rows - Using actual API data
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailBlock(
                                  'Insurance Co',
                                  insuranceCo,
                                  context,
                                ),
                                detailBlock('Policy Name', policyName, context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailBlock('Policy Type', policyType, context),
                                detailBlock('Policy No', policyNumber, context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailBlock(
                                  'Policy Start',
                                  policyStart,
                                  context,
                                ),
                                detailBlock('Policy End', policyEnd, context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailBlock(
                                  'Sum Insured',
                                  '₹ $sumInsured',
                                  context,
                                ),
                                detailBlock(
                                  'Health Card No.',
                                  healthCardNo,
                                  context,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                detailBlock(
                                  'No Of Dependent Covered',
                                  dependentCount != null
                                      ? dependentCount.toString()
                                      : '00',
                                  context,
                                ),
                              ],
                            ),

                            SizedBox(height: 10),
                            if (dependentDataList.length > 0)
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      _showDependentBottomSheet(
                                        context,
                                        dependentDataList,
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets
                                          .zero, // removes extra padding
                                      minimumSize: Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "View More",
                                          style: AppTextTheme.coloredSubTitle
                                              .copyWith(
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
                                      title:
                                          dependentDataList[0]['DependentName'] ??
                                          'N/A',
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
                                      title:
                                          dependentDataList[1]['DependentName'] ??
                                          'N/A',
                                      subtitle:
                                          'DOB: ${dependentDataList[1]['DateOfBirth'] ?? ''}',
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Download buttons
                            DottedBorderBtn(
                              label: isDownloadingDoc
                                  ? "Please wait..."
                                  : "Health Card",
                              iconPath: 'assets/icons/download_green.svg',
                              height: 50,
                              onPressed: isDownloadingDoc
                                  ? null
                                  : () {
                                      downloadHealthCard(context);
                                    },
                            ),

                            const SizedBox(height: 16),
                            // DottedBorderBtn(
                            //   label: "FAQ Documents",
                            //   iconPath: 'assets/icons/download_green.svg',
                            //   height: 50,
                            //   onPressed: () {},
                            // ),
                            SizedBox(height: 16),

                          

                            FutureBuilder(
                              future: getPolicyDocuments(policyNumber),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );

                                if (!snapshot.hasData || snapshot.data!.isEmpty)
                                  return Text("No documents available");

                                return buildDocumentButtons(snapshot.data!);
                              },
                            ),

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
                            PolicyBenefitsCard(policyNo: policyNumber),
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

  List<Map<String, dynamic>> policyList = [];
  int startPolicy = 0;
  final int pageSizePolicy = 10;
  bool isMorePolicyData = true;
  bool isFetchingPolicy = false;

  Future<void> getMyPolicies({bool isInitialLoad = false}) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
      return;
    }
    if (isInitialLoad) {
      startPolicy = 0;
      policyList.clear();
      isMorePolicyData = true;
    }

    if (!isMorePolicyData || isFetchingPolicy) return;

    isFetchingPolicy = true;
    if (mounted) setState(() {});

    final url = '$baseUrl/api/BCGModule/GetAllMyPolicyDetails';

    final body = {
      "Action": "GetData",
      "PageNumber": (startPolicy ~/ pageSizePolicy) + 1,
      "PageSize": pageSizePolicy,
      "EmployeeID": controllers.authUser['employeeId'].toString(),
    };

    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );

      if (response == null) {
        CustomToast.show(
          context: context,
          message: "Failed to load policies",
          success: false,
        );
      } else if (response["IsError"] == false) {
        final List result = response["Result"] ?? [];

        if (result.isEmpty) {
          isMorePolicyData = false;
        } else {
          final List<Map<String, dynamic>> newPolicies = result
              .cast<Map<String, dynamic>>();

          policyList.addAll(newPolicies);
          // Check if we received less than pageSize → no more data
          if (newPolicies.length < pageSizePolicy) {
            isMorePolicyData = false;
          }
          // Increment for next page
          startPolicy += pageSizePolicy;
        }
      } else {
        CustomToast.show(
          context: context,
          message: response["ErrorMessage"] ?? "Failed to load policies",
          success: false,
        );
      }
    } catch (e) {
      debugPrint("getMyPolicies exception: $e");
      CustomToast.show(
        context: context,
        message: "Something went wrong",
        success: false,
      );
    } finally {
      isFetchingPolicy = false;
      if (mounted) setState(() {});
    }
  }

  Future<Map<String, dynamic>?> getProfileDetails(
    String? employeeId,
    String? policyNo,
  ) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
    }
    const url = "$baseUrl/api/BCGModule/GetAllProfileEmployeeDetails";
    try {
      if (employeeId == null || employeeId.isEmpty) {
        print(" ERROR: EmployeeID is NULL or EMPTY");
        CustomToast.show(
          context: context,
          message: "Employee ID is missing",
          success: false,
        );
        return null;
      }
      if (policyNo == null || policyNo.isEmpty) {
        print(" ERROR: Policy Number is NULL or EMPTY");
        CustomToast.show(
          context: context,
          message: "Policy number is missing",
          success: false,
        );
        return null;
      }

      final body = {
        "Action": "GetAllMyProfileDetail",
        "EmployeeID": employeeId,
        "PolicyNo": policyNo,
      };

      print("📤 API REQUEST → GetAllProfileEmployeeDetails");
      print("➡ URL: $url");
      print("➡ BODY: ${jsonEncode(body)}");
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );
      print("📥 API RESPONSE:");
      print(response);

      // -------------------------
      // 📌 Response Validation
      // -------------------------
      if (response == null) {
        print(" ERROR: API response is NULL");
        CustomToast.show(
          context: context,
          message: "No response from server",
          success: false,
        );
        return null;
      }

      if (response["IsError"] == true) {
        print(" SERVER RETURNED ERROR: ${response["ErrorMessage"]}");
        CustomToast.show(
          context: context,
          message: response["ErrorMessage"] ?? "Server error",
          success: false,
        );
        return null;
      }

      if (response["Result"] == null) {
        print(" ERROR: Result key is NULL in response");
        CustomToast.show(
          context: context,
          message: "No profile details found",
          success: false,
        );
        return null;
      }
      final result = response["Result"];
      print("➡ Result: $result");
      if (result is List && result.isNotEmpty) {
        final Map<String, dynamic> profileData = result[0];
        print("PROFILE DETAILS EXTRACTED SUCCESSFULLY FROM LIST");
        print("➡ Profile Data: $profileData");
        return profileData;
      } else {
        print(" ERROR: Result is empty or not a list");
        CustomToast.show(
          context: context,
          message: "No profile data available",
          success: false,
        );
        return null;
      }
    } catch (e, stack) {
      print(" EXCEPTION OCCURRED:");
      print("➡ ERROR: $e");
      print("➡ STACKTRACE: $stack");

      CustomToast.show(
        context: context,
        message: "Something went wrong",
        success: false,
      );
      return null;
    }
  }

  ScrollController scrollController = ScrollController();
  bool isDownloading = false;
  Future<void> downloadHealthCard(BuildContext context) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
      return;
    }
    print("🔽 downloadManual() called");
    setState(() {
      isDownloading = true;
    });
    try {
      // -------------------------------------------------
      // 1️⃣ API 1 → Get HealthCardPath (PDF path)
      // -------------------------------------------------
      print("📡 API 1 → Fetching HealthCardPath...");

      final url1 = "$baseUrl/api/BCGModule/GetAllProfileEmployeeDetails";

      final body1 = {
        "Action": "GetAllHealthCardPath",
        "EmployeeID": controllers.authUser['employeeId'].toString(),
      };

      final res1 = await ApiService.postRequest(
        url: url1,
        body: body1,
        token: token,
      );
      print("✅ API 1 Response: $res1");

      if (res1 == null || res1["Result"] == null || res1["Result"].isEmpty) {
        CustomToast.show(
          context: context,
          message: "Invalid response from server",
          success: false,
        );
        return;
      }

      // Extract HealthCardPath
      final manualPath = res1["Result"][0]["HealthCardPath"] ?? "";

      print("📄 HealthCardPath received → $manualPath");

      if (manualPath.isEmpty) {
        print("❌ ERROR: Manual path empty!");
        CustomToast.show(
          context: context,
          message: "Manual path not found",
          success: false,
        );
        return;
      }

      // -------------------------------------------------
      // 2️⃣ API 2 → Fetch actual Base64 PDF
      // -------------------------------------------------
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
          message: res2?["ErrorMessage"] ?? "Invalid file data",
          success: false,
        );
        return;
      }

      print("📄 Base64 file received!");

      // -------------------------------------------------
      // 3️⃣ Decode Base64 → Save PDF
      // -------------------------------------------------
      final bytes = base64Decode(base64File);

      // Save into Downloads
      final directory = Directory("/storage/emulated/0/Download");
      final filePath = "${directory.path}/HealthCard.pdf";
      final file = File(filePath);

      await file.writeAsBytes(bytes);
      print("📁 PDF saved → $filePath");

      CustomToast.show(
        context: context,
        message: "Health Card saved in Download folder",
        success: true,
      );

      // -------------------------------------------------
      // 4️⃣ Open PDF
      // -------------------------------------------------
      // OpenFile.open(filePath);
    } catch (e, stack) {
      print("❌ ERROR in downloadManual()");
      print("🔍 Exception: $e");
      print("📌 StackTrace:\n$stack");

      CustomToast.show(
        context: context,
        message: "Something went wrong",
        success: false,
      );
    } finally {
      setState(() {
        isDownloading = false;
      });
    }
  }

  Future<List<Map<String, dynamic>>> getPolicyDocuments(String policyNo) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
    }
    const url = "$baseUrl/api/BCGModule/GetAllHRDashboardDetails";

    try {
      final payload = {
        "Action": "GetAllPolicyDocumentList",
        // "PolicyNo": "OG-26-1904-8403-00000022",
        "PolicyNo": policyNo,
      };
      print("Payload is ${payload}");
      final response = await ApiService.postRequest(
        url: url,
        body: payload,
        token: token,
      );
      print("Decoded get docs response is ${response}");
      if (response != null &&
          response['Result'] != null &&
          response['IsError'] == false) {
        return List<Map<String, dynamic>>.from(response['Result']);
      }

      print("⚠️ Invalid API response → $response");
      return [];
    } catch (e, stack) {
      print("❌ Error in getPolicyDocuments: $e");
      print(stack);
      return [];
    }
  }

  bool isDownloadingDoc = false;
  Future<void> downloadDocument(BuildContext context, String filePath) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
      return;
    }
    setState(() {
      isDownloadingDoc = true;
    });
    const url = "$baseUrl/api/Account/DownloadDocument";

    try {
      final overlayContext = Navigator.of(
        context,
        rootNavigator: true,
      ).overlay!.context;

      final payload = {"File": filePath};

      final response = await ApiService.postRequest(
        url: url,
        body: payload,
        token: token,
      );
      print("Download document response: $response");
      if (response == null || response['file'] == null) {
        CustomToast.show(
          context: overlayContext,
          message: "Unable to download file",
          success: false,
        );
        return;
      }

      final base64File = response['file'];
      final bytes = base64Decode(base64File);

      final directory = Directory("/storage/emulated/0/Download");
      final fileName = filePath.split("\\").last;
      final filePathSave = "${directory.path}/$fileName";

      final file = File(filePathSave);
      await file.writeAsBytes(bytes);

      CustomToast.show(
        context: overlayContext,
        message: "File saved to Downloads/$fileName",
        success: true,
      );
    } catch (e) {
      print("Download error: $e");
    } finally {
      setState(() {
        isDownloadingDoc = false;
      });
    }
  }

  Widget buildDocumentButtons(List<Map<String, dynamic>> docs) {
    return Column(
      children: docs.map((doc) {
        final name = doc['DocumentName'] ?? 'Document';
        final path = doc['DocumentPath'] ?? '';
        //isDownloading
        //   ? "Please wait..."
        //   : "Download user manual",
        return Column(
          children: [
            DottedBorderBtn(
              label: isDownloading ? "Please wait..." : name,
              iconPath: 'assets/icons/download_green.svg',
              height: 50,
              onPressed: isDownloading
                  ? null
                  : () {
                      downloadDocument(Get.context!, path);
                    },
            ),
            SizedBox(height: 12),
          ],
        );
      }).toList(),
    );
  }

  List dependentDataList = [];

  Future<List?> getDependentData() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
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
      print("Dependent Data Response: $response");
      return response["Result"] as List?; // <-- IMPORTANT
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  @override
  void initState() {
    super.initState();

    print("User Data : ${controllers.authUser}");
    print("User Data EmployeeId: ${controllers.authUser['employeeId']}");
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMyPolicies(); // Load next page
      }
    });

    getMyPolicies(isInitialLoad: true);
    fetchDependentData();
    // ← ADD THIS BLOCK: Auto-open details if policyNo was passed
    // if (widget.initialPolicyNo != null && widget.initialPolicyNo!.isNotEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     String employeeId = controllers.authUser['employeeId'].toString();
    //     _showPackageDetailsBottomSheet(
    //       context,
    //       employeeId,
    //       widget.initialPolicyNo!,
    //     );
    //   });
    // }
  }

  Future<void> fetchDependentData() async {
    final data = await getDependentData(); // call your API function

    if (!mounted) return; // safety

    setState(() {
      dependentDataList = data ?? [];
    });
  }

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
                child: policyList.isEmpty && !isFetchingPolicy
                    ? Center(child: Text("No policies found"))
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount:
                            policyList.length + (isMorePolicyData ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == policyList.length) {
                            getMyPolicies(); // Load next page
                            return Center(child: CircularProgressIndicator());
                          }

                          final policy = policyList[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
                            child: Container(
                              height: 150,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(20),
                              //   border: Border.all(color: AppTextTheme.primaryColor),
                              // ),
                              decoration: BoxDecoration(
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
                                              policy['PolicyType'] ?? 'N/A',
                                              style: AppTextTheme.paragraph,
                                            ),
                                            Text(
                                              '${policy['EmployeeName'] ?? 'N/A'}',
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
                                              '${policy['SumInsured'] ?? 'N/A'}',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,

                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0XffD8E9F1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),

                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text(
                                                '${policy['PolicyName'] ?? 'N/A'}',
                                                textAlign: TextAlign.center,
                                                style: AppTextTheme.paragraph
                                                    .copyWith(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0Xff00635F),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),

                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0XffD8E9F1),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text(
                                                '${policy['PolicyNo'] ?? 'N/A'}',
                                                textAlign: TextAlign.center,

                                                style: AppTextTheme.paragraph
                                                    .copyWith(
                                                      overflow:
                                                          TextOverflow.ellipsis,

                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0Xff00635F),
                                                    ),
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
                                      String policyNo = policy['PolicyNo']
                                          .toString();
                                      String employeeId = controllers
                                          .authUser['employeeId']
                                          .toString();

                                      _showPackageDetailsBottomSheet(
                                        context,
                                        employeeId,
                                        policyNo,
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
