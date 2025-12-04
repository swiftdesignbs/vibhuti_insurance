import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';

class PolicyBenefitsCard extends StatefulWidget {
  const PolicyBenefitsCard({super.key});

  @override
  State<PolicyBenefitsCard> createState() => _PolicyBenefitsCardState();
}

class _PolicyBenefitsCardState extends State<PolicyBenefitsCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final controllers = Get.put(StateController());
  List<BenefitItem> features = [];
  List<BenefitItem> extended = [];
  List<BenefitItem> excluded = [];

  Future<void> fetchBenefits() async {
    final token = controllers.authToken.toString();
    print("📌 Fetching benefits...");
    print("🔐 Token: $token");

    if (token.isEmpty) {
      print("❌ Token missing → redirecting to login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }

    const url = "$baseUrl/api/BCGModule/GetAllHRDashboardDetails";

    final body = {
      "Action": "GetAllInclusionAndExcluison",
     // "PolicyNo": "OG-26-1904-8403-00000022",
      "PolicyNo": "1234",
    };

    print("🌐 API Call → $url");
    print("📤 Request Body: $body");

    final response = await ApiService.postRequest(
      url: url,
      body: body,
      token: token,
    );

    print("📥 API Raw Response: $response");

    if (response != null && response["Result"] != null) {
      List data = response["Result"];
      print("📦 Total items received: ${data.length}");

      final items = data.map((e) => BenefitItem.fromJson(e)).toList();

      print("🔍 Parsed items:");
      for (var item in items.take(3)) {
        print("➡ ${item.category} | ${item.heading} | ${item.details}");
      }

      setState(() {
        features = items.where((e) => e.category == "Inclusion").toList();
        extended = items.where((e) => e.category == "AddOn").toList();
        excluded = items.where((e) => e.category == "Exclusion").toList();
      });

      print("✅ Filtered Data:");
      print("• Features: ${features.length}");
      print("• Extended: ${extended.length}");
      print("• Excluded: ${excluded.length}");
    } else {
      print("❌ No Result key in API response");
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    fetchBenefits();
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  BorderRadius _getIndicatorRadius() {
    switch (_tabController.index) {
      case 0:
        return const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(0),
        );
      case 1:
        return const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        );
      case 2:
        return const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(18),
        );
      default:
        return BorderRadius.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppTextTheme.primaryColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey.shade300,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppTextTheme.primaryColor,
                  borderRadius: _getIndicatorRadius(),
                ),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                tabs: [
                  Tab(
                    child: Text(
                      "Features",
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Extended",
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Excluded",
                      style: TextStyle(
                        fontFamily: 'FontMain',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: FeatureTabContent(items: features),
                  ),
                  SingleChildScrollView(
                    child: FeatureTabContent(items: extended),
                  ),
                  SingleChildScrollView(
                    child: FeatureTabContent(items: excluded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureTabContent extends StatelessWidget {
  final List<BenefitItem> items;

  const FeatureTabContent({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text(
          "No data found",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      );
    }

    // Group items into pairs (2 per row)
    final List<List<BenefitItem>> rows = [];
    for (int i = 0; i < items.length; i += 2) {
      final end = (i + 2 < items.length) ? i + 2 : items.length;
      rows.add(items.sublist(i, end));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: rows.map((pair) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // First item
                Expanded(
                  child: FeatureItem(
                    title: pair[0].heading,
                    description: pair[0].details,
                  ),
                ),
                const SizedBox(width: 16), // Space between two items
                // Second item (only if exists)
                pair.length > 1
                    ? Expanded(
                        child: FeatureItem(
                          title: pair[1].heading,
                          description: pair[1].details,
                        ),
                      )
                    : const Expanded(
                        child: SizedBox(),
                      ), // Empty space if odd number
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({required this.title, required this.description, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.subTitle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: AppTextTheme.paragraph.copyWith(
            fontSize: 9,
            color: const Color(0xFF303030),
            // height: 1.4,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

class BenefitItem {
  final String heading;
  final String details;
  final String category;

  BenefitItem({
    required this.heading,
    required this.details,
    required this.category,
  });

  factory BenefitItem.fromJson(Map<String, dynamic> json) {
    return BenefitItem(
      heading: json["HeadingColumn"]?.toString() ?? "N/A",
      details: json["Details"]?.toString() ?? "N/A",
      category: json["CategoryType"]?.toString() ?? "",
    );
  }
}
