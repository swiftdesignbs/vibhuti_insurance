import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/health_claims/create_claim/claims_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/claim_status_widget.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class HealthClaims extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HealthClaims({super.key, required this.scaffoldKey});

  @override
  State<HealthClaims> createState() => _HealthClaimsState();
}

class _HealthClaimsState extends State<HealthClaims> {
  TextEditingController searchController = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController claimNo = TextEditingController();
  TextEditingController policyNo = TextEditingController();
  String? selectedValue;

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

  void _showClaimSubmissionBottomSheet(BuildContext context) {
    final List<String> options = ['Self', 'Dependent', 'Stakeholder'];

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.2), // Optional dimming

      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.44 : 0.50;

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
                heightFactor: sheetHeight,
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
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                      child: StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // --- Header ---
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Claim Submission",
                                        style: AppTextTheme.pageTitle,
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.grey[600],
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),

                                  // --- Question ---
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "For whom you wish to raise the claim?",
                                      style: AppTextTheme.subItemTitle,
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // --- Radio List (Dynamic) ---
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: options.length,
                                      itemBuilder: (context, index) {
                                        final option = options[index];
                                        final isSelected =
                                            selectedValue == option;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              setModalState(() {
                                                selectedValue = option;
                                              });
                                              Navigator.pop(context);
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ClaimsScreen(),
                                                ),
                                              );
                                            },
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                            child: Container(
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? const Color.fromARGB(
                                                        255,
                                                        210,
                                                        243,
                                                        241,
                                                      )
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                border: Border.all(
                                                  color:
                                                      AppTextTheme.primaryColor,
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Radio<String>(
                                                    visualDensity:
                                                        const VisualDensity(
                                                          horizontal: -4,
                                                          vertical: -4,
                                                        ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    value: option,
                                                    groupValue: selectedValue,
                                                    activeColor: AppTextTheme
                                                        .primaryColor,
                                                    onChanged: (value) {
                                                      setModalState(
                                                        () => selectedValue =
                                                            value!,
                                                      );
                                                    },
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    option,
                                                    style:
                                                        AppTextTheme.subTitle,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
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
  }

  void _showClaimStatusBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.6 : 0.85;

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
                heightFactor: sheetHeight,
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
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
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
                              Text(
                                "Claim Status",
                                style: AppTextTheme.pageTitle,
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.grey[600],
                                ),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Content
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Claim Initiated
                                  ClaimStatusWidget(
                                    title: "Claim Initiated",
                                    description:
                                        "Employees Can Easily Submit Their Reimbursement Claims Through The Portal, Ensuring A More Streamlined And Convenient Process For Them.",
                                    status: "completed",
                                  ),

                                  const SizedBox(height: 25),

                                  // Documents Received
                                  ClaimStatusWidget(
                                    title: "Documents Received",
                                    description:
                                        "Employees Are Kindly Requested To Submit The Required Documents Within 48 Hours Of Raising The Claim On The Portal To Ensure A Faster Resolution.",
                                    status: "completed",
                                  ),

                                  const SizedBox(height: 25),

                                  // Claim Submitted
                                  ClaimStatusWidget(
                                    title: "Claim Submitted",
                                    description:
                                        "The Employee Has Submitted The Required Documents To The TPA, And The Claim Is Currently Under Review.",
                                    status: "completed",
                                  ),

                                  const SizedBox(height: 25),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0XFF3BCF85).withOpacity(
                                        0.15,
                                      ), // light green background
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0XFF3BCF85),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Colors.green, // green dot
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          "Initiated Claims",
                                          style: TextStyle(
                                            // color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 25),

                                  // Under Process
                                  ClaimStatusWidget(
                                    title: "Under Process",
                                    description:
                                        "Your Claim Is Being Carefully Reviewed By The TPA Or Insurer, And We Appreciate Your Patience During This Process.",
                                    status: "completed",
                                  ),

                                  const SizedBox(height: 25),

                                  // Query Raised
                                  ClaimStatusWidget(
                                    title:
                                        "Query Raised (Information Required)",
                                    description:
                                        "We Kindly Request Additional Information Or Documents To Assist The TPA/Insurer In Processing Further.",
                                    status: "pending",
                                    onPendingAction: () {
                                      _showQueryBottomSheet(context);
                                    },
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
            ),
          ],
        );
      },
    );
  }

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
        final sheetHeight = screenHeight > 700 ? 0.7 : 0.90;

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
                                    ? _calendarView(context)
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

  void _showQueryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.8 : 0.85;

        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(color: Colors.black.withOpacity(0.1)),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: FractionallySizedBox(
                heightFactor: sheetHeight,
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
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Query",
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

                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  CustomTextFieldWithName(
                                    controller: patientName,
                                    ddName: "Patient Name",
                                    hintText: "Rahul Gandhi",
                                  ),
                                  CustomTextFieldWithName(
                                    controller: claimNo,
                                    ddName: "Claim No",
                                    hintText: "MUM-0740-CL-0002356",
                                  ),
                                  CustomTextFieldWithName(
                                    controller: policyNo,
                                    ddName: "Policy Name",
                                    hintText: "Group Mediclaim Floater",
                                  ),
                                  SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFC7C7),

                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.red,
                                            offset: Offset(3, 3),
                                            blurRadius: 0,
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Shortfall Reason",
                                            style: AppTextTheme.subTitle
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          const SizedBox(height: 10),

                                          bulletPoints(
                                            "Kindly provide claim form part A duly signed by policy holder.",
                                          ),
                                          bulletPoints(
                                            "Kindly provide investigation reports against submitted bill of Rs. 10,861/- (Agilus Diagnostics).",
                                          ),
                                          bulletPoints(
                                            "Kindly provide the original cancel cheque, passbook front page copy, and duly filled ECS form of insured/policy holder account.",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                  Text(
                                    "Upload Document",
                                    style: AppTextTheme.subTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  DottedBorderBtn(
                                    label: "Upload Document",
                                    iconPath: 'assets/icons/upload_icon.svg',
                                    height: 80,
                                  ),
                                  const SizedBox(height: 10),

                                  Text(
                                    "History",
                                    style: AppTextTheme.subTitle.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "01-02-2025",
                                        style: AppTextTheme.subTitle.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(
                                        child: Divider(
                                          color: Colors.grey,
                                          thickness: 1,
                                          indent:
                                              10, // space between text and divider
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),

                                  DottedBorderBtn(
                                    label: "Document",
                                    iconPath: 'assets/icons/nav4.svg',

                                    height: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  DottedBorderBtn(
                                    label: "Document",
                                    iconPath: 'assets/icons/nav4.svg',
                                    height: 50,
                                  ),
                                  const SizedBox(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFC7C7),
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.red,
                                            offset: Offset(6, 6),
                                            blurRadius: 0,
                                          ),
                                        ],
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Disclaimer",
                                            style: AppTextTheme.subTitle
                                                .copyWith(
                                                  color: Colors.black,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          const SizedBox(height: 10),

                                          bulletPoints(
                                            "Please scan and upload all medical claim documents using the document uploader. You can either:",
                                          ),
                                          bulletPoints(
                                            "Combine Multiple documents into a single PDF (Single Upload).",
                                          ),
                                          bulletPoints(
                                            "Accepted file formats: .Pdf, .Jpg, .Png",
                                          ),
                                          bulletPoints(
                                            "File size limit: 0MB to 25MB",
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Buttons(
                                      onPressed: () {},
                                      ddName: "Submit",
                                      width: double.infinity,
                                    ),
                                  ),
                                  SizedBox(height: 10),
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
            ),
          ],
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
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00635F), Color(0xFF004d40)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                blurRadius: 0,
                offset: Offset(6, 6),
              ),
            ],
          ),
          width: double.infinity,
          height: 60,
          child: FloatingActionButton.extended(
            onPressed: () {
              _showClaimSubmissionBottomSheet(context);
            },
            backgroundColor: AppTextTheme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            label: Text(
              "Create Claim",
              style: AppTextTheme.buttonText.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: widget.scaffoldKey,
      drawer: AppDrawer(
        scaffoldKey: widget.scaffoldKey,
        parentContext: context,
      ),
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text(
          'Health Claims',
          style: AppTextTheme.pageTitle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/icons/menu.svg",
            height: 16,
            width: 16,
          ),
          onPressed: () {
            widget.scaffoldKey.currentState?.openDrawer();
          },
        ),
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

            SizedBox(height: 15),

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
                        "assets/icons/calender.svg",
                        height: 30,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
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
                      vertical: 6,
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
                              width: 1,
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
                              Container(
                                decoration: BoxDecoration(
                                  //color: Colors.grey.shade300,
                                  color: Color(0xffD8E9F1).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Claim No: ${claim['claimNo']}",
                                    style: AppTextTheme.paragraph.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xff00635F),
                                    ),
                                  ),
                                ),
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
                                  _showClaimStatusBottomSheet(context);
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
                                      'Check Status',
                                      style: AppTextTheme.buttonText,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
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

Widget bulletPoints(String text) {
  final boldWords = [
    "Combine Multiple",
    "Single Upload",
    ".Pdf",
    ".Jpg",
    ".Png",
    "0MB to 25MB",
  ];

  List<TextSpan> spans = [];
  String workingText = text;

  for (String boldWord in boldWords) {
    if (workingText.contains(boldWord)) {
      final parts = workingText.split(boldWord);
      spans.add(TextSpan(text: parts[0])); // normal

      spans.add(
        TextSpan(
          text: boldWord,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      workingText = parts.length > 1 ? parts[1] : "";
    }
  }

  // remaining text
  if (workingText.isNotEmpty) {
    spans.add(TextSpan(text: workingText));
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•  ", style: TextStyle(fontSize: 16, height: 1.4)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextTheme.paragraph.copyWith(color: Colors.black87),
              children: spans,
            ),
          ),
        ),
      ],
    ),
  );
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
    default:
      return Colors.grey;
  }
}

Widget _calendarView(BuildContext context) {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _today = DateTime.now();

  return StatefulBuilder(
    builder: (context, setState) {
      return TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime(1900),
        lastDay: DateTime(2900),

        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },

        // 🔥 Style Today & Selected Day
        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: AppTextTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: const Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          todayTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),

          selectedDecoration: const BoxDecoration(
            color: AppTextTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: const Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          selectedTextStyle: const TextStyle(
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

          Navigator.pop(context, formattedDate);
        },
      );
    },
  );
}

/// FILTER TAB — YEAR LIST WITH RADIO BUTTONS
Widget _filterView(
  List<int> years,
  int selectedYear,
  Function(int) onYearSelect,
) {
  return ListView.builder(
    itemCount: years.length,
    itemBuilder: (context, index) {
      return RadioListTile<int>(
        value: years[index],
        groupValue: selectedYear,
        title: Text(
          years[index].toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (value) {
          onYearSelect(value!);
        },
      );
    },
  );
}
