import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/claim_history/admin_claim_history_PT_1.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/claim_history/claim_history.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class AdminClaimHistory extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const AdminClaimHistory({super.key, this.scaffoldKey});

  @override
  State<AdminClaimHistory> createState() => _AdminClaimHistoryState();
}

class _AdminClaimHistoryState extends State<AdminClaimHistory> {
  bool isDropdownOpen = false;
  bool isYearDropdownOpen = false;
  String? selectedCompany;
  String? selectedYear;

  List<String> companyList = [
    "TATA Consultancy",
    "Infosys Ltd",
    "Reliance Pvt Ltd",
    "Wipro India",
    "Vibhuti Insurance",
  ];

  List<String> yearRanges = [
    "2024 - 2025",
    "2023 - 2024",
    "2022 - 2023",
    "2021 - 2022",
    "2020 - 2021",
    "2019 - 2020",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Claim History",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Company Name", style: AppTextTheme.subItemTitle),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() => isDropdownOpen = !isDropdownOpen);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTextTheme.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCompany ?? "Select Company",
                      style: AppTextTheme.subTitle,
                    ),
                    Icon(
                      isDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
            if (isDropdownOpen)
              Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.all(8),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.teal.withOpacity(0.7)),
                ),
                child: ListView.builder(
                  itemCount: companyList.length,
                  itemBuilder: (context, index) {
                    final item = companyList[index];
                    final isSelected = selectedCompany == item;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCompany = item;
                          isDropdownOpen = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 6,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.teal
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.teal,
                                  width: 1.6,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(
                                      Icons.check,
                                      size: 16,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 10),
            const Text("Select Year", style: AppTextTheme.subItemTitle),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                setState(() => isYearDropdownOpen = !isYearDropdownOpen);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTextTheme.primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedYear ?? "Select Year",
                      style: AppTextTheme.subTitle,
                    ),
                    Icon(
                      isYearDropdownOpen
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
            if (isYearDropdownOpen)
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: EdgeInsets.zero,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.teal.withOpacity(0.7)),
                ),
                child: ListView.builder(
                  itemCount: yearRanges.length,
                  itemBuilder: (context, index) {
                    final item = yearRanges[index];
                    final isSelected = selectedYear == item;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedYear = item;
                          isYearDropdownOpen = false;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.zero,
                        child: Row(
                          children: [
                            Radio<String>(
                              value: item,
                              groupValue: selectedYear,
                              activeColor: Colors.teal,
                              onChanged: (value) {
                                setState(() {
                                  selectedYear = value!;
                                  isYearDropdownOpen = false;
                                });
                              },
                            ),

                            Expanded(
                              child: Text(item, style: AppTextTheme.subTitle),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            Spacer(),
            Buttons(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminClaimHistoryPT1Screen(
                      scaffoldKey:
                          widget.scaffoldKey ?? GlobalKey<ScaffoldState>(),
                    ),
                  ),
                );
              },
              ddName: "Submit",
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
