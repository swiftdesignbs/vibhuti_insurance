import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:vibhuti_insurance_mobile_app/screens/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/wellness_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class AppDrawer extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PersistentTabController? controller;

  const AppDrawer({super.key, required this.scaffoldKey, this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(color: AppTextTheme.appBarColor),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: Colors.grey.shade200,
                          child: Image.asset(
                            'assets/icons/profile_icon.png',
                            height: 24,
                            width: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: AppTextTheme.pageTitle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Krishnan Murthy',
                              style: AppTextTheme.pageTitle.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 50,
                    right: 20,
                    child: IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.closeDrawer();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 28,
                        color: Color(0XFF004370),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            _buildSectionHeader('MASTER'),
            _buildMenuItem(
              title: 'Dashboard',
              iconPath: 'assets/icons/dashboard.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                if (controller != null) {
                  controller!.jumpToTab(0);
                }
              },
            ),
            _buildMenuItem(
              title: 'My Policy',
              iconPath: 'assets/icons/policy.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
                if (controller != null) {
                  controller!.jumpToTab(1);
                }
              },
            ),
            _buildMenuItem(
              title: 'Wellness Services',
              iconPath: 'assets/icons/wellness.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();

                pushScreen(
                  context,
                  screen: WellnessServicesScreen(scaffoldKey: scaffoldKey),
                  withNavBar: true,
                );
              },
            ),
            _buildMenuItem(
              title: 'Booking List',
              iconPath: 'assets/icons/booking_list.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();

                print('Available navigation methods check...');

                try {
                  pushScreen(
                    context,
                    screen: BookingScreen(scaffoldKey: scaffoldKey),
                    withNavBar: true,
                  );
                  print('pushScreen executed successfully');
                } catch (e) {
                  print('pushScreen failed: $e');

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          BookingScreen(scaffoldKey: scaffoldKey),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            _buildSectionHeader('TRANSACTION'),
            _buildMenuItem(
              title: 'Health Claims',
              iconPath: 'assets/icons/health_claims.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _buildMenuItem(
              title: 'Other Claims',
              iconPath: 'assets/icons/other_Claims.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _buildMenuItem(
              title: 'Claim Query',
              iconPath: 'assets/icons/wellness.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _buildMenuItem(
              title: 'TPA Claim Status',
              iconPath: 'assets/icons/tpa_claim.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _buildMenuItem(
              title: 'Wallet',
              iconPath: 'assets/icons/wallet.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            _buildMenuItem(
              title: 'Logout',
              iconPath: 'assets/icons/logout_icon.png',
              onTap: () {
                scaffoldKey.currentState?.closeDrawer();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title,
        style: AppTextTheme.subTitle.copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(left: 30),
        child: Image.asset(
          iconPath,
          height: 30,
          width: 30,
          color: const Color(0XFF004370),
        ),
      ),
      title: Text(
        title,
        style: AppTextTheme.subTitle.copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      minLeadingWidth: 0,
    );
  }
}
