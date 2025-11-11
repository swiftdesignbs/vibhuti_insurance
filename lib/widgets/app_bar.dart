import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';

class AppBarUtils {
  static AppBar buildCommonAppBar({
    required BuildContext context,
    required String screenTitle,
    String? userName,
    GlobalKey<ScaffoldState>? scaffoldKey,
    List<Widget>? actions,
    bool showWelcomeText = false,
    bool showImplyingIcon = false,
  }) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: AppTextTheme.appBarColor,
      title: showWelcomeText
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: AppTextTheme.pageTitle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  userName ?? "User Name",
                  style: AppTextTheme.pageTitle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Text(
              screenTitle,
              style: AppTextTheme.pageTitle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
      automaticallyImplyLeading: showImplyingIcon,
      leading: scaffoldKey != null
          ? IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openDrawer();
              },
              icon: Image.asset('assets/icons/menu.png', height: 24, width: 24),
            )
          : null,
      actions: actions,
    );
  }
}
