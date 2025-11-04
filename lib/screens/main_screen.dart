import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'package:vibhuti_insurance_mobile_app/screens/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';

import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_appdrawer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentTabConfig> _buildTabs() {
    return [
      PersistentTabConfig(
        screen: DashboardScreen(scaffoldKey: _scaffoldKey),
        item: ItemConfig(
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: AppTextTheme.primaryColor,
            child: Image.asset(
              'assets/icons/nav1.png',
              height: 40,
              width: 40,
              color: Colors.white,
            ),
          ),
          inactiveIcon: Image.asset(
            'assets/icons/nav1.png',
            height: 40,
            width: 40,
          ),
          // title: "",
        ),
      ),
      PersistentTabConfig(
        screen: MyPolicyScreen(scaffoldKey: _scaffoldKey),
        item: ItemConfig(
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: AppTextTheme.primaryColor,
            child: Image.asset(
              'assets/icons/nav2.png',
              height: 40,
              width: 40,
              color: Colors.white,
            ),
          ),
          inactiveIcon: Image.asset(
            'assets/icons/nav2.png',
            height: 40,
            width: 40,
          ),
          // title: "",
        ),
      ),
      PersistentTabConfig(
        screen: NotificationScreen(scaffoldKey: _scaffoldKey),
        item: ItemConfig(
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: AppTextTheme.primaryColor,
            child: Image.asset(
              'assets/icons/nav3.png',
              height: 40,
              width: 40,
              color: Colors.white,
            ),
          ),
          inactiveIcon: Image.asset(
            'assets/icons/nav3.png',
            height: 40,
            width: 40,
          ),
          //  title: "",
        ),
      ),
      PersistentTabConfig(
        screen: DentalCheckUpScreen(scaffoldKey: _scaffoldKey),
        item: ItemConfig(
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: AppTextTheme.primaryColor,
            child: Image.asset(
              'assets/icons/nav4.png',
              height: 40,
              width: 40,
              color: Colors.white,
            ),
          ),
          inactiveIcon: Image.asset(
            'assets/icons/nav4.png',
            height: 40,
            width: 40,
          ),
          //  title: "",
        ),
      ),
      PersistentTabConfig(
        screen: SettingsScreen(scaffoldKey: _scaffoldKey),
        item: ItemConfig(
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: AppTextTheme.primaryColor,
            child: Image.asset(
              'assets/icons/nav5.png',
              height: 40,
              width: 40,
              color: Colors.white,
            ),
          ),
          inactiveIcon: Image.asset(
            'assets/icons/nav5.png',
            height: 40,
            width: 40,
          ),
          //  title: "",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(scaffoldKey: _scaffoldKey, controller: _controller),
      body: PersistentTabView(
        // context,
        controller: _controller,
        tabs: _buildTabs(),
        navBarBuilder: (navBarConfig) => Style1BottomNavBar(
          height: 70,
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            padding: EdgeInsets.only(top: 10, bottom: 0, left: 0, right: 0),
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
        ),

        //   backgroundColor: Colors.grey[50],
        stateManagement: false,
        hideNavigationBar: false,
        screenTransitionAnimation: const ScreenTransitionAnimation(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}
