import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'package:vibhuti_insurance_mobile_app/screens/employee/employee_booking_module/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/claim_history/claim_history.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';
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
  late PersistentTabController _controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: widget.initialIndex);
  }

  List<Widget> _buildScreens() {
    return [
      DashboardScreen(scaffoldKey: _scaffoldKey),
      MyPolicyScreen(scaffoldKey: _scaffoldKey),
      WhatsappScreen(scaffoldKey: _scaffoldKey),
      ClaimHistoryScreen(scaffoldKey: _scaffoldKey),
      NotificationScreen(scaffoldKey: _scaffoldKey),
      // 👈 Replaced here
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: activeIcon('assets/icons/nav1.svg'),
        inactiveIcon: inActiveIcon('assets/icons/nav1.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: activeIcon('assets/icons/nav2.svg'),
        inactiveIcon: inActiveIcon('assets/icons/nav2.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: activeIcon('assets/icons/nav3.svg'),
        inactiveIcon: inActiveIcon('assets/icons/nav3.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: activeIcon('assets/icons/nav4.svg'),
        inactiveIcon: inActiveIcon('assets/icons/nav4.svg'),
      ),
      PersistentBottomNavBarItem(
        icon: activeIcon('assets/icons/nav5.svg'),
        inactiveIcon: inActiveIcon('assets/icons/nav5.svg'),
      ),
    ];
  }

  Widget activeIcon(String asset) => Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Color(0XFF00635F),
          offset: const Offset(4, 4), // X, Y offset
          blurRadius: 0, // No blur
          spreadRadius: 0,
        ),
      ],
    ),
    child: CircleAvatar(
      radius: 19,
      backgroundColor: AppTextTheme.primaryColor,
      child: SvgPicture.asset(
        asset,
        height: 22,
        width: 22,
        color: Colors.white,
      ),
    ),
  );

  Widget inActiveIcon(String asset) =>
      SvgPicture.asset(asset, height: 22, width: 22);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(
        scaffoldKey: _scaffoldKey,
        controller: _controller,
        parentContext: context,
      ),
      backgroundColor: Colors.white,
      body: PersistentTabView(
        navBarHeight: kBottomNavigationBarHeight * 1.20,

        padding: const EdgeInsets.symmetric(vertical: 8),

        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        backgroundColor: Colors.white,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          colorBehindNavBar: Colors.white,
        ),
        navBarStyle: NavBarStyle.style6,
      ),
    );
  }
}
