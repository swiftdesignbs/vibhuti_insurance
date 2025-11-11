import 'package:flutter/material.dart';

import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';

class SettingsScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const SettingsScreen({super.key, this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Settings", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => scaffoldKey?.currentState?.openDrawer(),
          icon: Image.asset('assets/icons/menu.png', height: 24, width: 24),
        ),
      ),
      body: const Center(
        child: Text("⚙️ Settings", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
