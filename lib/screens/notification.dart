import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/my_policy/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/wellness_module/health/health_check_up.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/profile/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification.dart';

class NotificationScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const NotificationScreen({super.key, this.scaffoldKey});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Notifications", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => scaffoldKey?.currentState?.openDrawer(),
          icon: SvgPicture.asset('assets/icons/menu.svg', height: 16, width: 16),
        ),
      ),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text("⚙️ Notifications", style: TextStyle(fontSize: 22)),
      ),
    );
  }
}
