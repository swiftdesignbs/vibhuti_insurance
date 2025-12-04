import 'dart:async';

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
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

// Dummy Screens (same as before)
class DentalCheckUpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DentalCheckUpScreen({super.key, this.scaffoldKey});

  @override
  State<DentalCheckUpScreen> createState() => _DentalCheckUpScreenState();
}

class _DentalCheckUpScreenState extends State<DentalCheckUpScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedValue = 'Option 1';
  String selectedGender = 'All';
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  final controllers = Get.put(StateController());
  void _showManuallyBottomSheet(
    BuildContext context,
    TextEditingController controller,
  ) {
    final List<String> items = [
      "Maharashtra",
      "Tamil Nadu",
      "Gujarat",
      "New Delhi",
      "Telangana",
      "Karnataka",
      "Assam",
    ];

    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
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
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Select Option",
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
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final relation = items[index];
                        return ListTile(
                          title: Text(relation),
                          onTap: () {
                            controller.text = relation;
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<dynamic> _allHospitals = [];
  bool isLoading = true;
  Future<void> getHospitalList() async {
    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");

      controllers.authUser.clear();

      Get.offAll(() => LoginSelection());
    }
    setState(() {
      isLoading = true; // always start loader
      _allHospitals = []; // clear old data during new search
    });
    final url = '$baseUrl/api/WellnessAPI/GetHospitalDetails';

    final body = {
      "SearchText": searchController.text.trim(),
      "Latitude": 19.0021632,
      "longitude": 72.8367104,
      "ServiceType": "CenterVisit",
      "PackageFor": "All",
      "State": "",
      "City": "",
      "Area": "",
      "Pincode": "",
      "RowId": 0,
      "TypeofCheckup": "DentalCheckup",
      "CompanyId": 204,
    };

    try {
      final response = await ApiService.postRequest(
        url: url,
        body: body,
        token: token,
      );

      if (response == null) {
        print("❌ No response");
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

        setState(() {
          _allHospitals = list;
          isLoading = false;
        });
      } else {
        print("❌ Error in JSON or empty list");
        setState(() {
          _allHospitals = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print("❌ Exception: $e");
      setState(() {
        _allHospitals = [];
        isLoading = false;
      });
    }
  }

  Timer? searchDelay;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getHospitalList(); // load initial list
    });

    searchController.addListener(() {
      if (searchDelay != null) searchDelay!.cancel();

      searchDelay = Timer(const Duration(milliseconds: 500), () {
        getHospitalList(); // auto-search
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppTextTheme.appBarColor,
      //   title: Text("Dental CheckUp", style: AppTextTheme.pageTitle),
      //   automaticallyImplyLeading: false,
      //   leading: IconButton(
      //     onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
      //     icon: SvgPicture.asset('assets/icons/menu.svg', height: 24, width: 24),
      //   ),
      // ),
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Dental CheckUp",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // --- Main content (scrollable) ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Location Options ---
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

                  // --- Use My Location ---
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

                  // --- Choose Manually ---
                  if (selectedValue == 'Option 2')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Network List", style: AppTextTheme.subTitle),
                        const SizedBox(height: 10),
                        CustomTextFieldWithName(
                          controller: stateController,
                          hintText: "Select State",
                          ddName: 'State',
                          suffixIcon: "assets/icons/down_icon.svg",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _showManuallyBottomSheet(context, stateController);
                          },
                          readOnly: true,
                        ),
                        CustomTextFieldWithName(
                          controller: cityController,
                          hintText: "Select City",
                          ddName: 'City',
                          suffixIcon: "assets/icons/down_icon.svg",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _showManuallyBottomSheet(context, cityController);
                          },
                          readOnly: true,
                        ),
                        CustomTextFieldWithName(
                          controller: areaController,
                          hintText: "Select Area",
                          ddName: 'Area',
                          suffixIcon: "assets/icons/down_icon.svg",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _showManuallyBottomSheet(context, areaController);
                          },
                          readOnly: true,
                        ),
                        CustomTextFieldWithName(
                          controller: pincodeController,
                          hintText: "Select Pincode",
                          ddName: 'Pincode',
                          suffixIcon: "assets/icons/down_icon.svg",
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            _showManuallyBottomSheet(
                              context,
                              pincodeController,
                            );
                          },
                          readOnly: true,
                        ),
                        SizedBox(height: 10),
                        Buttons(
                          onPressed: () {},
                          ddName: "Submit",
                          width: double.infinity,
                        ),
                      ],
                    ),
                  const SizedBox(height: 10),
                  Text('Diagnosis Centre List', style: AppTextTheme.subTitle),
                ],
              ),
            ),
          ),

          // --- Sticky Search Bar ---
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: _StickySearchBarDelegate(
              child: Container(
                //  color: Theme.of(context).scaffoldBackgroundColor,
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: CustomTextField(
                  controller: searchController,
                  hintText: "Search Hospital Name",
                  suffixIcon: "assets/icons/search_color.svg",
                ),
              ),
            ),
          ),

          // --- Gender Filters + Hospital List ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      genderOption('All'),
                      SizedBox(width: 18),
                      genderOption('Male'),
                      SizedBox(width: 18),

                      genderOption('Female'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Hospital Center / Count : 10',
                    style: AppTextTheme.subTitle,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // --- Loader ---
          if (isLoading)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          // --- Empty State ---
          else if (_allHospitals.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text("No hospitals found"),
                ),
              ),
            )
          // --- List View ---
          else
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final hospital = _allHospitals[index];

                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- DETAILS ---
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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

                        // --- BUTTON ---
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookSlotHealthCheckUpScreen(),
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
                              child: Text(
                                'Book Slot',
                                style: AppTextTheme.buttonText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: _allHospitals.length),
            ),
        ],
      ),
    );
  }

  Widget genderOption(String gender) {
    return InkWell(
      onTap: () => setState(() => selectedGender = gender),
      child: Row(
        children: [
          Radio<String>(
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: gender,
            groupValue: selectedGender,
            onChanged: (value) {
              setState(() => selectedGender = value!);
            },
          ),
          Text(gender, style: AppTextTheme.subTitle),
        ],
      ),
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
