import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class FeatureCarousel extends StatefulWidget {
  const FeatureCarousel({super.key});

  @override
  State<FeatureCarousel> createState() => _FeatureCarouselState();
}

class _FeatureCarouselState extends State<FeatureCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> items = [
    {
      "icon": "assets/icons/asset_1.svg",
      "title": "Buy Travel Insurance",
      "subtitle": "Protect your trip with travel insurance!",
      "button": "Coming Soon",
      "onTap": () {},
    },
    {
      "icon": "assets/icons/asset_1.svg",
      "title": "Motor Insurance",
      "subtitle": "Secure your vehicle instantly!",
      "button": "Buy Now",
      "onTap": () {},
    },
    {
      "icon": "assets/icons/asset_1.svg",
      "title": "Health Insurance",
      "subtitle": "Coverage that fits your family!",
      "button": "Learn More",
      "onTap": () {},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          options: CarouselOptions(
            height: 400,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.8,
            aspectRatio: 1.0,
            onPageChanged: (index, reason) {
              setState(() => currentIndex = index);
            },
          ),
          items: items.map((item) {
            return Column(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00635F),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppTextTheme.primaryColor),
                    boxShadow: [
                      BoxShadow(
                        color: AppTextTheme.primaryColor,
                        offset: const Offset(10, 8),
                      ),
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(item["icon"], fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  item["title"],
                  style: AppTextTheme.pageTitle.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                Text(
                  item["subtitle"],
                  textAlign: TextAlign.center,
                  style: AppTextTheme.subItemTitle.copyWith(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 20),

                Buttons(
                  onPressed: item["onTap"],
                  ddName: item["button"],
                  width: 150,
                ),
              ],
            );
          }).toList(),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            items.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: currentIndex == index ? 18 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? Color(0xff303030)
                    : Colors.grey.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
