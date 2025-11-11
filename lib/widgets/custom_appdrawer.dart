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
        child: Column(
          children: [
            // ✅ Fixed Header
            Container(
              height: 120,
              width: double.infinity,
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
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome',
                                style: AppTextTheme.pageTitle.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                'Krishnan Murthy',
                                style: AppTextTheme.pageTitle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
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

            // ✅ Scrollable Content
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  drwerHeader('MASTER'),
                  drawerMenuItem(
                    title: 'Dashboard',
                    iconPath: 'assets/icons/dashboard.png',
                    onTap: () => _navigateToTab(0),
                  ),
                  drawerMenuItem(
                    title: 'My Policy',
                    iconPath: 'assets/icons/policy.png',
                    onTap: () => _navigateToTab(1),
                  ),
                  drawerMenuItem(
                    title: 'Wellness Services',
                    iconPath: 'assets/icons/wellness.png',
                    onTap: () =>
                        _navigateToScreen(context, WellnessServicesScreen()),
                  ),
                  drawerMenuItem(
                    title: 'Booking List',
                    iconPath: 'assets/icons/booking_list.png',
                    onTap: () => _navigateToTab(3),
                  ),
                  const SizedBox(height: 16),

                  drwerHeader('TRANSACTION'),
                  drawerMenuItem(
                    title: 'Health Claims',
                    iconPath: 'assets/icons/health_claims.png',
                    onTap: () {},
                  ),
                  drawerMenuItem(
                    title: 'Other Claims',
                    iconPath: 'assets/icons/other_Claims.png',
                    onTap: () {},
                  ),
                  drawerMenuItem(
                    title: 'Claim Query',
                    iconPath: 'assets/icons/wellness.png',
                    onTap: () {},
                  ),
                  drawerMenuItem(
                    title: 'TPA Claim Status',
                    iconPath: 'assets/icons/tpa_claim.png',
                    onTap: () {},
                  ),
                  drawerMenuItem(
                    title: 'Wallet',
                    iconPath: 'assets/icons/wallet.png',
                    onTap: () {},
                  ),
                  drawerMenuItem(
                    title: 'Logout',
                    iconPath: 'assets/icons/logout_icon.png',
                    onTap: () => displayLogOutModal(context),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToTab(int index) {
    scaffoldKey.currentState?.closeDrawer();
    if (controller != null) {
      controller!.jumpToTab(index);
    }
  }

  // In lib/widgets/custom_appdrawer.dart

  void _navigateToScreen(BuildContext context, Widget screen) {
    // Close the drawer first
    scaffoldKey.currentState?.closeDrawer();

    // Add a slight delay to allow the drawer animation to start closing smoothly
    Future.delayed(const Duration(milliseconds: 250), () {
      // Use the 'context' passed into this function directly.
      // The 'pushScreen' function from the package handles the nested navigation logic correctly.
      pushScreen(
        context, // Use the provided BuildContext
        screen: screen,
        withNavBar: true, // This flag ensures the navbar remains visible
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
      );
    });
  }

  void displayLogOutModal(BuildContext context) {
    scaffoldKey.currentState?.closeDrawer();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout', style: AppTextTheme.pageTitle),
          content: const Text(
            'Are you sure you want to logout?',
            style: AppTextTheme.subTitle,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Cancel',
                style: AppTextTheme.coloredButtonText,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Logout',
                style: AppTextTheme.coloredButtonText,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget drwerHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Text(
        title,
        style: AppTextTheme.subTitle.copyWith(
          color: Colors.grey.shade600,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget drawerMenuItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Image.asset(
          iconPath,
          height: 24,
          width: 24,
          color: const Color(0XFF004370),
        ),
      ),
      title: Text(
        title,
        style: AppTextTheme.subTitle.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
      onTap: onTap,
      // contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      minLeadingWidth: 0,
    );
  }
}
