import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_checkup_form.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';

class BookSlotHealthCheckUpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final String hospitalId;
  final String pincode;
  final String selectedGender;

  const BookSlotHealthCheckUpScreen({
    super.key,
    this.scaffoldKey,
    required this.hospitalId,
    required this.pincode,
    required this.selectedGender,
  });

  @override
  State<BookSlotHealthCheckUpScreen> createState() =>
      _BookSlotHealthCheckUpScreenState();
}

class _BookSlotHealthCheckUpScreenState
    extends State<BookSlotHealthCheckUpScreen> {
  final controllers = Get.put(StateController());
  List<dynamic> testPackage = [];
  bool isLoading = true;

  void _showPackageDetailsBottomSheet(
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
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(color: Colors.black.withOpacity(0.1)),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: 0.85,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
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
                          Expanded(
                            child: Text(
                              package['PackageName']?.toString() ??
                                  'Package Details',
                              style: AppTextTheme.pageTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close, color: Colors.black),
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
                                "Included Tests:",
                                style: AppTextTheme.subTitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),

                              if (package['itemsList'] != null &&
                                  package['itemsList'] is List)
                                ...(package['itemsList'] as List).map<Widget>((
                                  item,
                                ) {
                                  return buildBulletPoint(
                                    item['items']?.toString() ?? '',
                                  );
                                }).toList()
                              else
                                Center(
                                  child: Text(
                                    "No test details available",
                                    style: AppTextTheme.paragraph,
                                  ),
                                ),

                              const SizedBox(height: 20),
                              Text(
                                "Please Take Note Of The Following Points:",
                                style: AppTextTheme.subTitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              buildBulletPoint(
                                "If any above treatment is done along with doctor consultation and medicine, then only it is covered under dental treatment.",
                              ),
                              buildBulletPoint(
                                "Only consultation charges and medicine charges are not payable under dental package.",
                              ),
                              buildBulletPoint(
                                "Please inform customer service if you are diabetic or a cardiac patient.",
                              ),
                              buildBulletPoint(
                                "If any above treatment is done along with cleaning and polishing, then is covered under dental treatment.",
                              ),
                              buildBulletPoint(
                                "Only cleaning and polishing is not payable.",
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
              style: AppTextTheme.paragraph.copyWith(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _getTestPackage() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }
    if (!mounted) return;

    setState(() => isLoading = true);

    final url = '$baseUrl/api/WellnessAPI/WellnessGetPlanDetails';

    final body = {
      "HostpitalId": widget.hospitalId.toString(),
      "Pincode": widget.pincode.toString(),
      "PackageFor": widget.selectedGender,
      "EmployeeId": controllers.authUserProfileData['employeeId'].toString(),
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    print("API Request Body: $body");

    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );

      if (!mounted) return;

      print("API Response: $response");

      if (response!['IsError'] == false && response['Result'] != null) {
        setState(() {
          testPackage = response['Result'];
          print("testPackage: $testPackage");

          isLoading = false;
        });
      } else {
        setState(() {
          testPackage = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("Exception in _getTestPackage: $e");
      if (!mounted) return;
      setState(() {
        testPackage = [];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("hospitalId: ${widget.hospitalId}");
    print("pincode: ${widget.pincode}");
    print("selectedGender: ${widget.selectedGender}");
    _getTestPackage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Book Slot",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + 16,
          ),
          child: Column(
            children: [
              if (isLoading)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (testPackage.isEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Text(
                      "No test packages available",
                      style: AppTextTheme.subTitle,
                    ),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  itemCount: testPackage.length,
                  itemBuilder: (context, index) {
                    final test = testPackage[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppTextTheme.primaryColor),
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
                                  children: [
                                    Expanded(
                                      child: Text(
                                        test['PackageName']?.toString() ??
                                            'Test Package',
                                        style: AppTextTheme.subTitle,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              "Offer price",
                                              style: AppTextTheme.paragraph,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 2),
                                        Text(
                                          "₹${test['MRP']?.toStringAsFixed(0) ?? '0'}",
                                          style: AppTextTheme.subTitle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD8E9F1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    child: Text(
                                      "Includes ${test['itemsList']?.length?.toString() ?? '0'} Tests",
                                      style: AppTextTheme.paragraph.copyWith(
                                        color: Color(0xFF00635F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    for (var item
                                        in test['itemsList']?.take(2) ?? [])
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 6,
                                            height: 6,
                                            decoration: BoxDecoration(
                                              color: AppTextTheme.primaryColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          SizedBox(width: 4),
                                          Flexible(
                                            child: Text(
                                              item['items']?.toString() ?? '',
                                              style: AppTextTheme.paragraph,
                                              maxLines: 2,
                                              //   overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    // if ((test['itemsList']?.length ?? 0) > 2)
                                    //   Text(
                                    //     '...',
                                    //     style: AppTextTheme.paragraph,
                                    //   ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _showPackageDetailsBottomSheet(
                                      context,
                                      test,
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF7BD9D6),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Know More',
                                        style: AppTextTheme.buttonText,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HealthCheckUpFormScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF00B3AC),
                                      borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Book Package',
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
            ],
          ),
        ),
      ),
    );
  }
}
