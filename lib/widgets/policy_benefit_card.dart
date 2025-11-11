import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class PolicyBenefitsCard extends StatefulWidget {
  const PolicyBenefitsCard({super.key});

  @override
  State<PolicyBenefitsCard> createState() => _PolicyBenefitsCardState();
}

class _PolicyBenefitsCardState extends State<PolicyBenefitsCard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          topLeft: Radius.circular(12),
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
          topRight: Radius.circular(12),
        );
      default:
        return BorderRadius.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(color: AppTextTheme.primaryColor),
      // ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTextTheme.primaryColor),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2D7C78), // darker teal shadow
            offset: const Offset(6, 6), // shadow position
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
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
                      style: AppTextTheme.subTitle.copyWith(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Extended",
                      style: AppTextTheme.subTitle.copyWith(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Excluded",
                      style: AppTextTheme.subTitle.copyWith(
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab Views
          Container(
            padding: const EdgeInsets.all(12),
            height: 180,
            child: TabBarView(
              controller: _tabController,
              children: const [
                FeatureTabContent(),
                FeatureTabContent(),
                FeatureTabContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureTabContent extends StatelessWidget {
  const FeatureTabContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeatureItem(
              title: "Sum Insured",
              description: "₹10,00,000/- Floater",
            ),
            FeatureItem(title: "Room Rent", description: "Single Private Room"),
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FeatureItem(
              title: "Maternity",
              description:
                  "Covered from day 1, Normal Delivery and Caesarian Delivery maximum ₹3,00,000/- for first 2 children only.",
            ),
            FeatureItem(
              title: "Pre-existing diseases/condition",
              description: "Covered from day 1",
            ),
          ],
        ),
      ],
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String title;
  final String description;

  const FeatureItem({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextTheme.subTitle),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextTheme.paragraph.copyWith(color: Color(0xFF303030)),
          ),
        ],
      ),
    );
  }
}
