import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/screens/admin/employee_details.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;

class AdminClientScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const AdminClientScreen({super.key, this.scaffoldKey});
  @override
  State<AdminClientScreen> createState() => _AdminClientScreenState();
}

class _AdminClientScreenState extends State<AdminClientScreen> {
  TextEditingController searchController = TextEditingController();
  final TextEditingController occupation = TextEditingController();
  final controllers = Get.put(StateController());
  List clientDataInfo = [];
  bool isLoading = true;
  int start = 0;
  final int pageSize = 10;
  Timer? searchDelay;

  bool isMoreData = true; // API still has more pages
  bool isFetchingMore = false; // Prevent duplicate calls
  ScrollController scrollController = ScrollController();
  Future<void> clientData({bool isInitialLoad = false}) async {
    if (isInitialLoad) {
      start = 0;
      clientDataInfo.clear();
      isMoreData = true;
    }

    if (!isMoreData || isFetchingMore) return;

    setState(() => isFetchingMore = true);

    const url = "api/CorporateCompany/CompanyID_DataTableList";
    final completeURL = "$baseUrl$url";

    final body = {
      "RoleType": controllers.authUser['RoleType'].toString(),
      "UserId": controllers.authUser['UserId'].toString(),
      "EmployeeCode": 0,
      "IsOtherClaim": false,
      "IsDependentClaim": false,
      "Types": null,
      "IsNewClaimYN": false,
      "NewClaimYN": 0,
      "Start": start,
      "PageSize": pageSize,
      "CompanyID": 0,
      "Search": searchController.text.trim(),
      "Sorting": "CompanyName asc",
      "Status": "",
      "ClaimStatus": null,
      "payload": null,
    };

    final response = await ApiService.postRequest(url: completeURL, body: body);

    if (response == null) {
      setState(() => isFetchingMore = false);
      return;
    }

    if (response["IsError"] == false && response["Result"] != null) {
      List newData = response["Result"];

      setState(() {
        clientDataInfo.addAll(newData);
        start += pageSize;
        isLoading = false;

        if (newData.length < pageSize) {
          isMoreData = false;
        }
      });
    }

    setState(() => isFetchingMore = false);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      clientData(isInitialLoad: true);
    });

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        clientData(); // Load more pages
      }
    });

    // SEARCH LISTENER (with debounce)
    searchController.addListener(() {
      if (searchDelay != null) searchDelay!.cancel();

      searchDelay = Timer(const Duration(milliseconds: 600), () {
        clientData(isInitialLoad: true);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Client",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CustomTextField(
              controller: searchController,
              hintText: "Search",
              suffixIcon: "assets/icons/search_color.svg",
            ),

            SizedBox(height: 5),
            Expanded(
              child: ListView.builder(
                controller: scrollController, // IMPORTANT for pagination
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: clientDataInfo.length + 1, // includes loader item
                itemBuilder: (context, index) {
                  // 🔥 When index reaches end, show loader
                  if (index == clientDataInfo.length) {
                    return isMoreData
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          )
                        : const SizedBox(); // no more data
                  }

                  // Safe data
                  final claim = clientDataInfo[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 6,
                    ),
                    decoration: index == 0
                        ? BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0XFF00635F),
                                offset: Offset(6, 6),
                                blurRadius: 0,
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF56B3AD),
                              width: 1.2,
                            ),
                          )
                        : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),

                            border: Border.all(
                              color: Color(0xFF56B3AD),
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
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          claim['CompanyName'] ?? '',
                                          style: AppTextTheme.paragraph,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Wrap(
                                          children: [
                                            Text(
                                              "${claim['CompanyName'] ?? ''} - ${claim['CompanyCode'] ?? ''}",
                                              style: AppTextTheme.subTitle,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 12),

                                  // ---------- STATUS ----------
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
                                          borderRadius: BorderRadius.circular(
                                            15,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
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
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // ------------ CONTACT ------------
                              Container(
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffD8E9F1,
                                  ).withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "${claim['ContactPerson']} - ${claim['Mobile'] ?? claim['Mobile']}",
                                  textAlign: TextAlign.center,
                                  style: AppTextTheme.paragraph.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff00635F),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ------------ BOTTOM BUTTONS ------------
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
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
                                      'View Details',
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
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF00B3AC),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Edit Details',
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
  return isActive
      ? const Color(0xFF3BCF85) // Green
      : const Color(0xFF6C757D); // Grey
}
