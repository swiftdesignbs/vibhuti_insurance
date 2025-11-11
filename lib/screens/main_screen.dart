import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:vibhuti_insurance_mobile_app/screens/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';
import 'package:vibhuti_insurance_mobile_app/screens/whatsapp_screen.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';

class MainScreen extends StatefulWidget {
  final int initialIndex;
  const MainScreen({super.key, this.initialIndex = 0});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final PersistentTabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<PersistentTabConfig> tabScreen() => [
    PersistentTabConfig(
      screen: DashboardScreen(scaffoldKey: _scaffoldKey),
      item: ItemConfig(
        icon: activeIcon('assets/icons/nav1.png'),
        inactiveIcon: inActiveIcon('assets/icons/nav1.png'),
        //  title: "Dashboard",
      ),
    ),
    PersistentTabConfig(
      screen: MyPolicyScreen(scaffoldKey: _scaffoldKey),
      item: ItemConfig(
        icon: activeIcon('assets/icons/nav2.png'),
        inactiveIcon: inActiveIcon('assets/icons/nav2.png'),
        // title: "My Policy",
      ),
    ),
    PersistentTabConfig(
      screen: WhatsappScreen(scaffoldKey: _scaffoldKey),
      item: ItemConfig(
        icon: activeIcon('assets/icons/nav3.png'),
        inactiveIcon: inActiveIcon('assets/icons/nav3.png'),
        //  title: "Notifications",
      ),
    ),
    PersistentTabConfig(
      screen: BookingScreen(scaffoldKey: _scaffoldKey),
      item: ItemConfig(
        icon: activeIcon('assets/icons/nav4.png'),
        inactiveIcon: inActiveIcon('assets/icons/nav4.png'),
        //  title: "Booking",
      ),
    ),
    PersistentTabConfig(
      screen: SettingsScreen(scaffoldKey: _scaffoldKey),
      item: ItemConfig(
        icon: activeIcon('assets/icons/nav5.png'),
        inactiveIcon: inActiveIcon('assets/icons/nav5.png'),
        //  title: "Settings",
      ),
    ),
  ];

  Widget activeIcon(String asset) => CircleAvatar(
    radius: 20,
    backgroundColor: AppTextTheme.primaryColor,
    child: Image.asset(asset, height: 35, width: 35, color: Colors.white),
  );

  Widget inActiveIcon(String asset) =>
      Image.asset(asset, height: 35, width: 35, color: Colors.grey[600]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(scaffoldKey: _scaffoldKey, controller: _controller),
      body: PersistentTabView(
        controller: _controller,
        tabs: tabScreen(),
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: const NavBarDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, -3),
              ),
            ],
          ),
        ),
        // Optional: Hide navbar on scroll
        // handleAndroidBackButton: true,
        // resizeToAvoidBottomInset: true,
        stateManagement: true,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          // animateTabTransition: true,
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
