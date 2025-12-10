import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:vibhuti_insurance_mobile_app/screens/employee/employee_booking_module/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/claim_history/claim_history.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/health_claims/health_claims.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/wellness_screen.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class AppDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final PersistentTabController? controller;
  final BuildContext parentContext; // 👈 Add this
  final List<BuildContext?>? tabContexts;
  const AppDrawer({
    super.key,
    required this.scaffoldKey,
    this.controller,
    required this.parentContext,
    this.tabContexts, // 👈 Required
  });

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final dataController = Get.put(StateController());

  logout() async {
    try {
      await dataController.unsetAuth();
    } catch (err) {}

    Get.offAll(() => const LoginSelection());
  }

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
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                offset: const Offset(4, 4), // X, Y offset
                                blurRadius: 0, // No blur
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey.shade200,
                            child: SvgPicture.asset(
                              'assets/icons/profile_icon.svg',
                              height: 24,
                              width: 24,
                            ),
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
                                '${dataController.authUserProfileData['employeeName']}',
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
                    top: 60,
                    right: 10,
                    child: IconButton(
                      onPressed: () {
                        widget.scaffoldKey.currentState?.closeDrawer();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 24,
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
                    iconPath: 'assets/icons/dashboard.svg',
                    onTap: () {
                      widget.scaffoldKey.currentState?.closeDrawer();

                      PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
                        widget.parentContext,
                      );

                      _navigateToTab(0);
                    },

                    iconColor: Color(0XFF004370),
                  ),
                  drawerMenuItem(
                    title: 'My Policy',
                    iconPath: 'assets/icons/policy.svg',
                    onTap: () {
                      widget.scaffoldKey.currentState?.closeDrawer();

                      PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
                        widget.parentContext,
                      );

                      _navigateToTab(1);
                    },
                  ),
                  drawerMenuItem(
                    title: 'Wellness Services',
                    iconPath: 'assets/icons/wellness.svg',
                    onTap: () {
                      widget.scaffoldKey.currentState?.closeDrawer();

                      _navigateToTab(0);

                      Future.delayed(const Duration(milliseconds: 250), () {
                        PersistentNavBarNavigator.pushNewScreen(
                          widget.parentContext, // 👈 use main screen context
                          screen: WellnessServicesScreen(
                            scaffoldKey: GlobalKey<ScaffoldState>(),
                          ),
                          withNavBar: true, // ✅ keeps navbar visible
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      });
                    },
                  ),
                  drawerMenuItem(
                    title: 'Booking List',
                    iconPath: 'assets/icons/booking_list.svg',
                    onTap: () {
                      widget.scaffoldKey.currentState?.closeDrawer();

                      _navigateToTab(0);
                      Future.delayed(const Duration(milliseconds: 250), () {
                        PersistentNavBarNavigator.pushNewScreen(
                          widget.parentContext,
                          screen: BookingScreen(
                            scaffoldKey: GlobalKey<ScaffoldState>(),
                          ),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      });
                    },
                  ),

                  drwerHeader('TRANSACTION'),
                  drawerMenuItem(
                    title: 'Health Claims',
                    iconPath: 'assets/icons/health_claims.svg',
                    onTap: () {
                      widget.scaffoldKey.currentState?.closeDrawer();

                      _navigateToTab(0);
                      Future.delayed(const Duration(milliseconds: 250), () {
                        PersistentNavBarNavigator.pushNewScreen(
                          widget.parentContext, // 👈 use main screen context
                          screen: HealthClaims(
                            scaffoldKey: GlobalKey<ScaffoldState>(),
                          ),
                          withNavBar: true, // ✅ keeps navbar visible
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      });
                    },
                  ),

                  drawerMenuItem(
                    title: 'Claim History',
                    iconPath: 'assets/icons/tpa_claim.svg',
                    onTap: () {
                      widget.scaffoldKey.currentState?.closeDrawer();

                      PersistentNavBarNavigator.popUntilFirstScreenOnSelectedTabScreen(
                        widget.parentContext,
                      );

                      _navigateToTab(3);
                    },
                  ),
                  drawerMenuItem(
                    title: 'Wallet',
                    iconPath: 'assets/icons/wallets.svg',
                    onTap: () {},
                  ),
                  SizedBox(height: 20),
                  drawerMenuItem(
                    title: 'Logout',
                    textColor: Color(0XFFFF4242),
                    iconPath: 'assets/icons/logout_icon.svg',
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
    widget.scaffoldKey.currentState?.closeDrawer();
    if (widget.controller != null) {
      widget.controller!.jumpToTab(index);
    }
  }

  void displayLogOutModal(BuildContext context) {
    widget.scaffoldKey.currentState?.closeDrawer();
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: AppTextTheme.coloredButtonText,
              ),
            ),
            TextButton(
              onPressed: () {
                logout();
              },
              child: Text(
                'Logout',
                style: AppTextTheme.coloredButtonText.copyWith(
                  color: Color(0XFFFF4242),
                ),
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
    Color? iconColor, // optional
    Color? textColor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 40, bottom: 2),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 50,
              alignment: Alignment.center,
              child: SvgPicture.asset(
                iconPath,
                height: 20,
                width: 20,
                color: iconColor,
                //color: const Color(0XFF004370),
              ),
            ),
            Text(
              title,
              style: AppTextTheme.subTitle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
