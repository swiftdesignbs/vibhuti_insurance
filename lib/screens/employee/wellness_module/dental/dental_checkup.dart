import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/dental/book_slot_dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/book_slot_health_checkup_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_dropdown.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class DentalCheckUpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DentalCheckUpScreen({super.key, this.scaffoldKey});

  @override
  State<DentalCheckUpScreen> createState() => _DentalCheckUpScreenState();
}

class _DentalCheckUpScreenState extends State<DentalCheckUpScreen> {
  final controllers = Get.put(StateController());

  TextEditingController searchController = TextEditingController();
  String selectedValue = 'Option 1';
  String selectedGender =
      'All'; // CHANGED: Gender filter variable - uses 'All', 'Male', 'Female' to match API
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  List<dynamic> _allHospitals = [];
  bool isLoading = true;
  List<dynamic> _allManualSearchHospitals = [];
  bool isLoading2 = true;

  // Note: Since API handles gender filtering via PackageFor parameter,
  // we don't need client-side filtering. The lists already contain gender-filtered data.

  Future<void> getHospitalList() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }
    if (!mounted) return;
    setState(() {
      isLoading = true;
      _allHospitals = [];
    });
    final url = '$baseUrl/api/WellnessAPI/GetHospitalDetails';

    final body = {
      "SearchText": searchController.text.trim(),
      "Latitude": 19.0021632,
      "longitude": 72.8367104,
      "ServiceType": "CenterVisit",
      "PackageFor":
          selectedGender, // CHANGED: Use selectedGender directly (API expects 'All', 'Male', 'Female')
      "State": "",
      "City": "",
      "Area": "",
      "Pincode": "",
      "RowId": 0,
      "TypeofCheckup": "DentalCheckup",
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );

      if (response == null) {
        print("❌ No response");
        if (!mounted) return;
        setState(() {
          isLoading = false;
        });
        return;
      }

      final data = response;
      print("🏥 Hospital API Response: $data");

      if (data["IsError"] == false &&
          data["Result"] != null &&
          data["Result"]["Hospitaldata"] != null) {
        final list = List<Map<String, dynamic>>.from(
          data["Result"]["Hospitaldata"] ?? [],
        );
        if (!mounted) return;
        setState(() {
          _allHospitals = list;
          isLoading = false;
        });
      } else {
        print("❌ Error in JSON or empty list");
        if (!mounted) return;
        setState(() {
          _allHospitals = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Exception: $e");
      if (!mounted) return;
      setState(() {
        _allHospitals = [];
        isLoading = false;
      });
    }
  }

  Future<void> getManualSearchHospitalList() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }
    if (!mounted) return;
    setState(() {
      isLoading2 = true;
      _allManualSearchHospitals = [];
    });
    final url = '$baseUrl/api/WellnessAPI/GetHospitalDetails';

    final body = {
      "SearchText": searchController.text.trim(),
      "Latitude": null,
      "longitude": null,
      "ServiceType": "CenterVisit",
      "PackageFor": selectedGender,
      "RowId": 0,
      "TypeofCheckup": "DentalCheckup",
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    // Only add location fields if they are selected
    if (selectedState.isNotEmpty) {
      body["State"] = selectedState;
    }
    if (selectedCity != null && selectedCity!.isNotEmpty) {
      body["City"] = selectedCity;
    }
    if (selectedArea != null && selectedArea!.isNotEmpty) {
      body["Area"] = selectedArea;
    }
    if (pincodeController.text.trim().isNotEmpty) {
      body["Pincode"] = pincodeController.text.trim();
    }

    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );

      if (response == null) {
        print("❌ No response");
        if (!mounted) return;
        setState(() {
          isLoading2 = false;
        });
        return;
      }

      final data = response;
      print("🏥 Manual Search Hospital API Response: $data");
      if (data["IsError"] == false &&
          data["Result"] != null &&
          data["Result"]["Hospitaldata"] != null) {
        final list = List<Map<String, dynamic>>.from(
          data["Result"]["Hospitaldata"] ?? [],
        );
        if (!mounted) return;
        setState(() {
          _allManualSearchHospitals = list;
          isLoading2 = false;
        });
      } else {
        print("❌ Error in JSON or empty list");
        if (!mounted) return;
        setState(() {
          _allManualSearchHospitals = [];
          isLoading2 = false;
        });
      }
    } catch (e) {
      print("❌ Exception: $e");
      if (!mounted) return;
      setState(() {
        _allManualSearchHospitals = [];
        isLoading2 = false;
      });
    }
  }

  List<String> stateList = [];
  String selectedState = "";
  bool isStateLoading = false;

  Future<void> getStateList() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }
    if (!mounted) return;
    setState(() => isStateLoading = true);

    final url = '$baseUrl/api/WellnessAPI/GetStateList';

    final body = {
      "TypeOfCheckup": "DentalCheckup",
      "ServiceType": "CenterVisit",
      "PackageFor":
          selectedGender, // CHANGED: Add gender filter to state list API
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    final response = await ApiService.postRequest(
      url: url,
      body: body,
      token: token,
    );
    if (!mounted) return;
    if (response != null && response["Result"] != null) {
      if (!mounted) return;
      setState(() {
        stateList =
            response["Result"]["GetStateListAPI"]
                ?.map<String>((item) => item["State"].toString())
                .toList() ??
            [];
        isStateLoading = false;
      });
    } else {
      if (!mounted) return;
      setState(() => isStateLoading = false);
    }
  }

  List<String> cityList = [];
  String? selectedCity = "";
  bool isCityLoading = false;

  Future<void> getCityList(String state) async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }
    if (!mounted) return;
    setState(() {
      isCityLoading = true;
      cityList = [];
      selectedCity = "";
      selectedArea = null;
      pincodeController.text = "";
      areaList.clear();
    });

    final url = '$baseUrl/api/WellnessAPI/GetCityListbyState';

    final body = {
      "State": state,
      "ServiceType": "CenterVisit",
      "TypeOfCheckup": "DentalCheckup",
      "PackageFor":
          selectedGender, // CHANGED: Add gender filter to city list API
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    final response = await ApiService.postRequest(
      url: url,
      body: body,
      token: token,
    );
    if (!mounted) return;
    if (response != null &&
        response["Result"] != null &&
        response["Result"]["GetCityListbyStateAPI"] != null) {
      if (!mounted) return;
      setState(() {
        cityList = response["Result"]["GetCityListbyStateAPI"]
            .map<String>((item) => item["City"].toString())
            .toList();
        isCityLoading = false;
      });

      // Auto-call getManualSearchHospitalList when city is selected
      if (cityList.isNotEmpty) {
        await getManualSearchHospitalList();
      }
    } else {
      if (!mounted) return;
      setState(() => isCityLoading = false);
    }
  }

  List<String> areaList = [];
  String? selectedArea;
  bool isAreaLoading = false;

  Future<void> getAreaList() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }

    if (selectedCity == null || selectedCity!.isEmpty) return;
    if (!mounted) return;
    setState(() => isAreaLoading = true);

    final payload = {
      "State": selectedState,
      "City": selectedCity,
      "TypeOfCheckup": "DentalCheckup",
      "ServiceType": "CenterVisit",
      "PackageFor":
          selectedGender, // CHANGED: Add gender filter to area list API
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    final response = await ApiService.postRequest(
      url: "$baseUrl/api/WellnessAPI/GetAreaList",
      body: payload,
      token: token,
    );
    if (!mounted) return;
    if (response != null && response["Result"] != null) {
      final list = response["Result"]["GetAreaListAPI"] as List;
      if (!mounted) return;
      setState(() {
        areaList = list.map((e) => e["Area"].toString()).toList();
        isAreaLoading = false;
      });
    } else {
      if (!mounted) return;
      setState(() => isAreaLoading = false);
    }
  }

  bool isPincodeLoading = false;

  Future<void> getAreaPincode() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }

    if (selectedArea == null || selectedArea!.isEmpty) return;
    if (!mounted) return;
    setState(() => isPincodeLoading = true);

    final payload = {
      "State": selectedState,
      "City": selectedCity,
      "Area": selectedArea,
      "ServiceType": "CenterVisit",
      "TypeOfCheckup": "DentalCheckup",
      "PackageFor": selectedGender, // CHANGED: Add gender filter to pincode API
      "CompanyId": controllers.authUserProfileData['companyId'].toString(),
    };

    final response = await ApiService.postRequest(
      url: "$baseUrl/api/WellnessAPI/GetAreabypincode",
      body: payload,
      token: token,
    );
    if (!mounted) return;
    if (response != null && response["Result"] != null) {
      final list = response["Result"]["GetAreaListAPI"] as List;
      if (list.isNotEmpty) {
        if (!mounted) return;
        setState(() {
          pincodeController.text = list.first["Pincode"]?.toString() ?? "";
          isPincodeLoading = false;
        });
      }
    } else {
      if (!mounted) return;

      setState(() => isPincodeLoading = false);
    }
  }

  Timer? searchDelay;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getHospitalList();
      getStateList();
    });

    // searchController.addListener(() {
    //   if (searchDelay != null) searchDelay!.cancel();

    //   searchDelay = Timer(const Duration(milliseconds: 500), () {
    //     if (!mounted) return; // ADD THIS

    //     if (selectedValue == 'Option 1') {
    //       getHospitalList();
    //     } else if (selectedValue == 'Option 2' &&
    //         selectedState.isNotEmpty &&
    //         selectedCity != null &&
    //         selectedCity!.isNotEmpty) {
    //       getManualSearchHospitalList();
    //     }
    //   });
    // });

    searchController.addListener(() {
      if (searchDelay != null) searchDelay!.cancel();

      searchDelay = Timer(const Duration(milliseconds: 500), () {
        if (!mounted) return;

        if (selectedValue == 'Option 1') {
          getHospitalList(); // For Option 1, search works immediately
        } else if (selectedValue == 'Option 2') {
          // For Option 2, search should work regardless of location selection
          // If location filters are selected, use them; otherwise, just search by text
          if (selectedState.isNotEmpty &&
              selectedCity != null &&
              selectedCity!.isNotEmpty) {
            // Search with location filters
            getManualSearchHospitalList();
          } else if (searchController.text.trim().isNotEmpty) {
            // If only search text is entered without location, still search
            // You might need a different API call or modify the existing one
            // For now, let's just call getManualSearchHospitalList with empty location
            getManualSearchHospitalList();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    searchDelay?.cancel();
    searchController.dispose();
    super.dispose();
  }

  Widget buildHospitalCard(Map<String, dynamic> hospital) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTextTheme.primaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        hospital['Name'] ?? 'No Name',
                        style: AppTextTheme.subTitle,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/icons/fav_icon.svg",
                      height: 16,
                      width: 16,
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  hospital['Address'] ?? 'No Address',
                  style: AppTextTheme.paragraph,
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookSlotDentalCheckUpScreen(),
                ),
              );
            },
            child: Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppTextTheme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Center(
                child: Text('Book Slot', style: AppTextTheme.buttonText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // CHANGED: Build hospital count widget - moved to separate Sliver
  Widget _buildHospitalCount(int count) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Hospital/Centre Count: $count', style: AppTextTheme.subTitle),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Dental CheckUp",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() => selectedValue = 'Option 1');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              visualDensity: VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'Option 1',
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() => selectedValue = value!);
                              },
                            ),
                            const Text(
                              'Use My Location',
                              style: AppTextTheme.subTitle,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          setState(() => selectedValue = 'Option 2');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Radio<String>(
                              visualDensity: VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              value: 'Option 2',
                              groupValue: selectedValue,
                              onChanged: (value) {
                                setState(() => selectedValue = value!);
                              },
                            ),
                            const Text(
                              'Choose Manually',
                              style: AppTextTheme.subTitle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  if (selectedValue == 'Option 1')
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTextTheme.primaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 200,
                      child: const Center(
                        child: Text(
                          "Map Placeholder",
                          style: AppTextTheme.subTitle,
                        ),
                      ),
                    ),

                  if (selectedValue == 'Option 2')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Network List", style: AppTextTheme.subTitle),
                        const SizedBox(height: 10),

                        // State Dropdown with loader
                        isStateLoading
                            ? Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(strokeWidth: 2),
                                    SizedBox(width: 10),
                                    Text(
                                      "Loading states...",
                                      style: AppTextTheme.paragraph,
                                    ),
                                  ],
                                ),
                              )
                            : CustomDropdownOverlay(
                                label: "Select State",
                                options: stateList,
                                selectedValue: selectedState,
                                onSelected: (value) {
                                  setState(() {
                                    selectedState = value;
                                    selectedCity = null;
                                    selectedArea = null;
                                    pincodeController.text = "";
                                    areaList.clear();
                                  });
                                  getCityList(value);
                                },
                              ),
                        const SizedBox(height: 8),

                        // City Dropdown with loader
                        isCityLoading
                            ? Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(strokeWidth: 2),
                                    SizedBox(width: 10),
                                    Text(
                                      "Loading cities...",
                                      style: AppTextTheme.paragraph,
                                    ),
                                  ],
                                ),
                              )
                            : CustomDropdownOverlay(
                                label: "Select City",
                                options: cityList,
                                selectedValue: selectedCity,
                                enabled:
                                    selectedState.isNotEmpty && !isCityLoading,
                                onSelected: (value) {
                                  setState(() {
                                    selectedCity = value;
                                    selectedArea = null;
                                    pincodeController.text = "";
                                    areaList.clear();
                                  });
                                  getAreaList();
                                  getManualSearchHospitalList();
                                },
                              ),
                        const SizedBox(height: 8),

                        // Area Dropdown with loader
                        isAreaLoading
                            ? Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(strokeWidth: 2),
                                    SizedBox(width: 10),
                                    Text(
                                      "Loading areas...",
                                      style: AppTextTheme.paragraph,
                                    ),
                                  ],
                                ),
                              )
                            : CustomDropdownOverlay(
                                label: "Select Area",
                                options: areaList,
                                selectedValue: selectedArea,
                                enabled:
                                    selectedCity != null &&
                                    selectedCity!.isNotEmpty &&
                                    !isAreaLoading,
                                onSelected: (value) async {
                                  setState(() {
                                    selectedArea = value;
                                    pincodeController.text = "";
                                  });
                                  await getAreaPincode();
                                  await getManualSearchHospitalList();
                                },
                              ),
                        const SizedBox(height: 8),

                        isPincodeLoading
                            ? Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    CircularProgressIndicator(strokeWidth: 2),
                                    SizedBox(width: 10),
                                    Text(
                                      "Loading areas...",
                                      style: AppTextTheme.paragraph,
                                    ),
                                  ],
                                ),
                              )
                            : CustomTextFieldWithName(
                                keyboardType: TextInputType.number,
                                controller: pincodeController,
                                hintText: "Pincode",
                                ddName: 'Pincode',
                                readOnly: true,
                                enabled:
                                    selectedArea != null &&
                                    selectedArea!.isNotEmpty &&
                                    !isPincodeLoading,
                              ),
                      ],
                    ),

                  const SizedBox(height: 16),
                  Text('Diagnosis Centre List', style: AppTextTheme.subTitle),
                  const SizedBox(height: 10),
                ],
              ),
            ),

            SliverPersistentHeader(
              pinned: true,
              floating: false,
              delegate: _StickySearchBarDelegate(
                child: Container(
                  color: Colors.white,
                  child: CustomTextField(
                    controller: searchController,
                    hintText: "Search Hospital Name",
                    suffixIcon: "assets/icons/search_color.svg",
                  ),
                ),
              ),
            ),

            // NEW: Gender filter appears below search bar
            SliverToBoxAdapter(child: buildGenderFilter()),

            // Content based on selected option
            if (selectedValue == 'Option 1') ...[
              // NEW: Hospital count for Option 1
              if (!isLoading && _allHospitals.isNotEmpty)
                SliverToBoxAdapter(
                  child: _buildHospitalCount(
                    _allHospitals.length,
                  ), // CHANGED: Use _allHospitals directly
                ),

              if (isLoading)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (_allHospitals
                  .isEmpty) // CHANGED: Use _allHospitals directly
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("No hospitals found near your location"),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return buildHospitalCard(
                        _allHospitals[index],
                      ); // CHANGED: Use _allHospitals directly
                    },
                    childCount: _allHospitals.length,
                  ), // CHANGED: Use _allHospitals.length directly
                ),
            ] else if (selectedValue == 'Option 2') ...[
              // NEW: Hospital count for Option 2
              if (!isLoading2 && _allManualSearchHospitals.isNotEmpty)
                SliverToBoxAdapter(
                  child: _buildHospitalCount(
                    _allManualSearchHospitals.length,
                  ), // CHANGED: Use _allManualSearchHospitals directly
                ),

              if (isLoading2)
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (_allManualSearchHospitals
                  .isEmpty) // CHANGED: Use _allManualSearchHospitals directly
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text("No hospitals found in selected location"),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return buildHospitalCard(
                        _allManualSearchHospitals[index],
                      ); // CHANGED: Use _allManualSearchHospitals directly
                    },
                    childCount: _allManualSearchHospitals.length,
                  ), // CHANGED: Use _allManualSearchHospitals.length directly
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget buildGenderFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // All option
            InkWell(
              onTap: () {
                if (!mounted) return;
                setState(() {
                  selectedGender = 'All';
                });
                // Trigger search based on current selection
                if (selectedValue == 'Option 1') {
                  getHospitalList();
                } else if (selectedValue == 'Option 2') {
                  // For Option 2, always try to search
                  getManualSearchHospitalList();
                }
                // Also reload dropdown lists with gender filter
                if (selectedState.isNotEmpty) {
                  getCityList(selectedState);
                }
              },
              child: Row(
                children: [
                  Radio<String>(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 'All',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        selectedGender = value!;
                      });

                      if (selectedValue == 'Option 1') {
                        getHospitalList();
                      } else if (selectedValue == 'Option 2') {
                        getManualSearchHospitalList();
                      }

                      if (selectedState.isNotEmpty) {
                        getCityList(selectedState);
                      }
                    },
                  ),
                  Text('All', style: AppTextTheme.subTitle),
                ],
              ),
            ),
            SizedBox(width: 12),
            // Male option
            InkWell(
              onTap: () {
                if (!mounted) return;
                setState(() {
                  selectedGender = 'Male';
                });
                // Trigger search based on current selection
                if (selectedValue == 'Option 1') {
                  getHospitalList();
                } else if (selectedValue == 'Option 2') {
                  getManualSearchHospitalList();
                }
                // Also reload dropdown lists with gender filter
                if (selectedState.isNotEmpty) {
                  getCityList(selectedState);
                }
              },
              child: Row(
                children: [
                  Radio<String>(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        selectedGender = value!;
                      });
                      // Trigger search based on current selection
                      if (selectedValue == 'Option 1') {
                        getHospitalList();
                      } else if (selectedValue == 'Option 2') {
                        getManualSearchHospitalList();
                      }
                      // Also reload dropdown lists with gender filter
                      if (selectedState.isNotEmpty) {
                        getCityList(selectedState);
                      }
                    },
                  ),
                  Text('Male', style: AppTextTheme.subTitle),
                ],
              ),
            ),
            SizedBox(width: 12),
            // Female option
            InkWell(
              onTap: () {
                if (!mounted) return;
                setState(() {
                  selectedGender = 'Female';
                });
                // Trigger search based on current selection
                if (selectedValue == 'Option 1') {
                  getHospitalList();
                } else if (selectedValue == 'Option 2') {
                  getManualSearchHospitalList();
                }
                // Also reload dropdown lists with gender filter
                if (selectedState.isNotEmpty) {
                  getCityList(selectedState);
                }
              },
              child: Row(
                children: [
                  Radio<String>(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      if (!mounted) return;
                      setState(() {
                        selectedGender = value!;
                      });
                      // Trigger search based on current selection
                      if (selectedValue == 'Option 1') {
                        getHospitalList();
                      } else if (selectedValue == 'Option 2') {
                        getManualSearchHospitalList();
                      }
                      // Also reload dropdown lists with gender filter
                      if (selectedState.isNotEmpty) {
                        getCityList(selectedState);
                      }
                    },
                  ),
                  Text('Female', style: AppTextTheme.subTitle),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StickySearchBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickySearchBarDelegate({required this.child});

  @override
  double get minExtent => 65;
  @override
  double get maxExtent => 65;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
