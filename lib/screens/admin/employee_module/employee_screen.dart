import 'dart:async';
import 'dart:convert';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/employee_module/employee_details.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';

class EmployeeScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const EmployeeScreen({super.key, this.scaffoldKey});
  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  TextEditingController searchController = TextEditingController();
  final TextEditingController occupation = TextEditingController();

  final controllers = Get.put(StateController());
  List employeeList = [];
  bool isLoading = true;
  int start = 0;
  final int pageSize = 10;
  Timer? searchDelay;

  bool isMoreData = true; // API still has more pages
  bool isFetchingMore = false; // Prevent duplicate calls
  ScrollController scrollController = ScrollController();

  Future<void> getEmployeeList({bool isInitialLoad = false}) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      setState(() {
        isLoading = false;
        isFetchingMore = false;
      });
      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
      return;
    }
    if (isInitialLoad) {
      start = 0;
      employeeList.clear();
      isMoreData = true;
    }

    if (!isMoreData || isFetchingMore) return;

    isFetchingMore = true;
    setState(() {});

    final url = '$baseUrl/api/Employee/GetEmployeeList';
    final body = {
      "RoleType": controllers.authUser['RoleType'].toString(),
      "UserId": controllers.authUser['UserId'].toString(),
      "CompanyID": selectedCompanyId ?? 0,
      "EmployeeTypeID": 0,
      "ModificationType": 0,
      "Start": start,
      "PageSize": pageSize,
      "Search": searchController.text.trim(),
      "Sorting": "EmployeeName asc",
      "Status": null,
      "ClaimStatus": null,
      "payload": null,
    };

    final response = await ApiService.postRequest(
      url: url,
      body: body,
      token: token,
    );

    if (response == null) {
      isFetchingMore = false;
      if (mounted) setState(() {});
      return;
    }

    if (response["IsError"] == false) {
      List newData = response["Result"]["data"] ?? [];
      print("newData : $newData");
      employeeList.addAll(newData.cast<Map<String, dynamic>>());
      start += pageSize;

      if (newData.length < pageSize) {
        isMoreData = false;
      }
    }

    isFetchingMore = false;
    if (mounted) setState(() {});
  }

  List<Map<String, dynamic>> companyList = [];
  bool isLoadingCompanies = false;

  Future<void> fetchCompanyList() async {
    setState(() {
      isLoadingCompanies = true;
      true;
    });
    try {
      final url = '$baseUrl/api/Employee/GetCompanyList';

      final response = await http.get(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {
        String encrypted = response.body;
        if (encrypted.startsWith('"') && encrypted.endsWith('"')) {
          encrypted = encrypted.substring(1, encrypted.length - 1);
        }
        final decrypted = AesEncryption.decryptAES(encrypted);
        final json = jsonDecode(decrypted);
        if (json["IsError"] == false) {
          final List data = json["Result"] ?? [];
          companyList = data.cast<Map<String, dynamic>>();
        }
        print("companyList : $companyList");
      } else {
        print("Failed to load companies: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching companies: $e");
    }
    setState(() {
      isLoadingCompanies = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchCompanyList();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getEmployeeList(isInitialLoad: true);
    });

    scrollController.addListener(() {
      if (!isFetchingMore &&
          scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200) {
        getEmployeeList();
      }
    });
  }

  String? selectedCompany;
  int? selectedCompanyId;
  void _showOccupationBottomSheet(BuildContext context) {
    bool isDropdownOpen = false;
    double sheetHeight = 150;
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: sheetHeight,
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Company Name", style: AppTextTheme.subItemTitle),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDropdownOpen = !isDropdownOpen;
                        sheetHeight = isDropdownOpen ? 300 : 150;
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
                          Expanded(
                            child: Text(
                              selectedCompany ?? "Select Company",
                              style: AppTextTheme.subItemTitle.copyWith(
                                color: selectedCompany == null
                                    ? Colors.grey.shade600
                                    : Colors.black87,
                                fontWeight: selectedCompany != null
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis, // Now works!
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
                          border: Border.all(
                            color: Colors.teal.withOpacity(0.7),
                          ),
                        ),
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                            itemCount: companyList.length,
                            itemBuilder: (context, index) {
                              final item = companyList[index];
                              final isSelected = selectedCompany == item;

                              return InkWell(
                                // onTap: () {
                                //   setState(() {
                                //     selectedCompany = item["CompanyName"];
                                //     isDropdownOpen = false;
                                //     sheetHeight = 150;
                                //   });
                                // },
                                onTap: () {
                                  setState(() {
                                    selectedCompany = item["CompanyName"];
                                    selectedCompanyId =
                                        item["CompanyID"]; // ✅ set ID
                                    searchController.text =
                                        selectedCompany!; // ✅ show in search
                                  });
                                  Navigator.pop(context);
                                  getEmployeeList(isInitialLoad: true);
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
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
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
                                          item["CompanyName"],
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
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Employee",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
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
                        _showOccupationBottomSheet(context);
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/bldg.svg",
                        height: 30,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: employeeList.isEmpty && !isMoreData
                  ? Center(
                      child: Text(
                        "No records found",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      controller: scrollController,
                      itemCount: employeeList.length + (isMoreData ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == employeeList.length) {
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final claim = employeeList[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 6,
                          ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                claim['CompanyName'] ?? 'NAN',
                                                style: AppTextTheme.paragraph,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Wrap(
                                                children: [
                                                  Text(
                                                    "${claim['EmployeeName'] ?? 'NAN'} - ${claim['EmployeeCode'] ?? 'NAN'}",
                                                    style:
                                                        AppTextTheme.subTitle,
                                                  ),
                                                ],
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
                                                color: getStatusColor(
                                                  claim['IsActive'] == true,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 6,
                                                  ),
                                              child: Text(
                                                claim['IsActive'] == true
                                                    ? "Active"
                                                    : "Inactive",
                                                style: AppTextTheme.paragraph
                                                    .copyWith(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 12),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(
                                                0xffD8E9F1,
                                              ).withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
                                              child: Text(
                                                "${claim['Mobile'] ?? "NAN"}",
                                                textAlign: TextAlign.center,
                                                style: AppTextTheme.paragraph
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xff00635F),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: const Color(
                                                0xffD8E9F1,
                                              ).withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                "${claim['EmailID'] ?? "NAN"}",
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: AppTextTheme.paragraph
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                        0xff00635F,
                                                      ),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 5),

                                        Expanded(
                                          flex: 1,

                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(
                                                0xffD8E9F1,
                                              ).withOpacity(0.7),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                5.0,
                                              ),
                                              child: Text(
                                                "${claim['SumInsured'] ?? "NAN"}",
                                                textAlign: TextAlign.center,

                                                style: AppTextTheme.paragraph
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color(0xff00635F),
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
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
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EmployeeScreenPT1(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF00B3AC),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
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

Color getStatusColor(bool isActive) {
  return isActive ? const Color(0xFF3BCF85) : const Color(0xFF6C757D);
}
