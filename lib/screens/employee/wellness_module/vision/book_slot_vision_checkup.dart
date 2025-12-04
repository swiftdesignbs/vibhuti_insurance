import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_checkup_form.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import '../health/book_slot_health_checkup_screen.dart'; // make sure you import your BookSlotVisionCheckUpScreen file

class BookSlotVisionCheckUpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const BookSlotVisionCheckUpScreen({super.key, this.scaffoldKey});

  @override
  State<BookSlotVisionCheckUpScreen> createState() =>
      _BookSlotVisionCheckUpScreenState();
}

class _BookSlotVisionCheckUpScreenState
    extends State<BookSlotVisionCheckUpScreen> {
  final List<Map<String, dynamic>> testPackage = [
    {
      "TestName": "Full Body Checkup",
      "price": 2499,
      "includedTestCount": 65,
      "overviewTestName": "Liver, Kidney, Thyroid",
    },
    {
      "TestName": "Diabetes Screening Package",
      "price": 899,
      "includedTestCount": 12,
      "overviewTestName": "Sugar, Lipid, Urine",
    },
    {
      "TestName": "Heart Health Package",
      "price": 1799,
      "includedTestCount": 20,
      "overviewTestName": "ECG, Cholesterol, Enzymes",
    },
    {
      "TestName": "Women Wellness Package",
      "price": 2199,
      "includedTestCount": 40,
      "overviewTestName": "Hormones, Thyroid, Calcium",
    },
    {
      "TestName": "Senior Citizen Health Package",
      "price": 2999,
      "includedTestCount": 75,
      "overviewTestName": "Liver, Kidney, Heart",
    },
    {
      "TestName": "Basic Health Checkup",
      "price": 699,
      "includedTestCount": 25,
      "overviewTestName": "Blood, Sugar, Urine",
    },
    {
      "TestName": "Thyroid Profile",
      "price": 499,
      "includedTestCount": 3,
      "overviewTestName": "T3, T4, TSH",
    },
    {
      "TestName": "Liver Function Test (LFT)",
      "price": 599,
      "includedTestCount": 10,
      "overviewTestName": "Bilirubin, SGPT, SGOT",
    },
    {
      "TestName": "Kidney Function Test (KFT)",
      "price": 649,
      "includedTestCount": 8,
      "overviewTestName": "Urea, Creatinine, Sodium",
    },
    {
      "TestName": "Pre-Employment Health Package",
      "price": 1299,
      "includedTestCount": 30,
      "overviewTestName": "Blood, Urine, X-Ray",
    },
  ];
  void _showPackageDetailsBottomSheet(
    BuildContext context,
    Map<String, dynamic> package,
  ) {
    showModalBottomSheet(useRootNavigator: true,
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
                            Text("Eye Package", style: AppTextTheme.pageTitle),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        buildBulletPoint(
                          "Only Powered glass / lenses are covered.",
                        ),
                        buildBulletPoint(
                          "One Spectacle or one pair of contact lens is payable within family upto 10k",
                        ),
                        buildBulletPoint(
                          "Disposable contact lenses are also payable subject to period Of contact lenses",
                        ),

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

                        const SizedBox(height: 20),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Book Slot",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),   backgroundColor: Colors.white,
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   backgroundColor: AppTextTheme.appBarColor,
      //   title: Text("Book Slot", style: AppTextTheme.pageTitle),
      //   iconTheme: const IconThemeData(color: Colors.black),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: kBottomNavigationBarHeight + 16,
          ),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: testPackage.length,
                itemBuilder: (context, index) {
                  final test = testPackage[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(20),
                    //   border: Border.all(color: AppTextTheme.primaryColor),
                    // ),
                    decoration: index == 0
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppTextTheme.primaryColor,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0XFF00635F),
                                // darker teal shadow
                                offset: const Offset(6, 6), // shadow position
                                blurRadius: 0,
                              ),
                            ],
                          )
                        : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppTextTheme.primaryColor,
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
                                children: [
                                  Expanded(
                                    child: Text(
                                      test['TestName'],
                                      style: AppTextTheme.subTitle,
                                    ),
                                  ),
                                    Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,

                                        borderRadius: BorderRadius.circular(15),
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
                                      "₹${test['price']}",
                                      style: AppTextTheme.subTitle,
                                    ),
                                  ],
                                ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,

                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "Includes ${test['includedTestCount']} Tests",
                                    style: AppTextTheme.paragraph.copyWith(
                                      color: AppTextTheme.primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Includes: ${test['overviewTestName']}",
                                style: AppTextTheme.paragraph,
                              ),
                            ],
                          ),
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _showPackageDetailsBottomSheet(context, test);
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
                                          const HealthCheckUpFormScreen(),
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
