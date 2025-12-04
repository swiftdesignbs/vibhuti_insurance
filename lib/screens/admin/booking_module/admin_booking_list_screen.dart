import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/booking_module/admin_booking_list.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:http/http.dart' as http;
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';

class AdminBookingListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const AdminBookingListScreen({super.key, this.scaffoldKey});

  @override
  State<AdminBookingListScreen> createState() => _AdminBookingListScreenState();
}

class _AdminBookingListScreenState extends State<AdminBookingListScreen> {
  TextEditingController companyNameController = TextEditingController();
  List<String> companyList = [
    "Alvsrez & Marsal India Pvt Ltd",
    "Azz Infraservices Ltd",
    "The Boston Consulting Group",
    "Ace Human Capital Ltd",
    "Trinity",
    "House of Hiranandani",
  ];
  List<String> statusList = [
    "Under Process",
    "Query",
    "Settled",
    "In Progress",
    "Cancelled",
  ];

  String? selectedCompany;
  bool isDropdownOpen = false;
  String? selectedStatus;
  bool isDropdownOpen_2 = false;
  // Add these two controllers at the top of your State class
  final ScrollController _companyScrollController = ScrollController();
  final ScrollController _statusScrollController = ScrollController();

  var getCompanyDataList;

  Future<void> getCompanyData() async {
    var response = await http.get(
      Uri.parse("${baseUrl}" + "api/Employee/GetCompanyList"),
    );
    if (response.statusCode == 200) {
      final encrypted = response.body.replaceAll('"', '');

      final decrypted = AesEncryption.decryptAES(encrypted);
      setState(() {
        getCompanyDataList = jsonDecode(decrypted);
      });
      print("getCompanyDataList : ${getCompanyDataList['Result'][0]}");
    } else {
      print("❌ Error: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    getCompanyData();
  }

  @override
  void dispose() {
    _companyScrollController.dispose();
    _statusScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Booking List",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Company Name", style: AppTextTheme.subItemTitle),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen = !isDropdownOpen;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTextTheme.primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedCompany ?? "Company Name",
                      style: AppTextTheme.subItemTitle.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SvgPicture.asset(
                      isDropdownOpen
                          ? "assets/icons/up_icon.svg"
                          : "assets/icons/down_icon.svg",
                      color: AppTextTheme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),

            if (isDropdownOpen)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.teal.withOpacity(0.7)),
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _companyScrollController,
                    child: ListView.builder(
                      controller: _companyScrollController,
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
                ),
              ),
            SizedBox(height: 10),
            const Text("Status", style: AppTextTheme.subItemTitle),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () {
                setState(() {
                  isDropdownOpen_2 = !isDropdownOpen_2;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTextTheme.primaryColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedStatus ?? "Status",
                      style: AppTextTheme.subItemTitle.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    SvgPicture.asset(
                      isDropdownOpen_2
                          ? "assets/icons/up_icon.svg"
                          : "assets/icons/down_icon.svg",
                      color: AppTextTheme.primaryColor,
                    ),
                  ],
                ),
              ),
            ),

            if (isDropdownOpen_2)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.teal.withOpacity(0.7)),
                  ),
                  child: Scrollbar(
                    controller: _statusScrollController,
                    thumbVisibility: true,
                    child: ListView.builder(
                      controller: _statusScrollController,
                      itemCount: statusList.length,
                      itemBuilder: (context, index) {
                        final item = statusList[index];
                        final isSelected = selectedStatus == item;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedStatus = item;
                              isDropdownOpen_2 = false;
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
                ),
              ),
            Spacer(),
            Buttons(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminBookingList()),
                );
              },
              ddName: "Submit",
              width: double.infinity,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
