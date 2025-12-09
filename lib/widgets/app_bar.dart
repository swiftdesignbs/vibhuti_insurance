import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      titleSpacing: 0,
      title: showWelcomeText
          ? Text(
              "Welcome, ${userName ?? "User Name"}",
              style: AppTextTheme.pageTitle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
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
              icon: SvgPicture.asset(
                'assets/icons/menu.svg',
                height: 16,
                width: 16,
              ),
            )
          : null,
      actions: actions,
    );
  }
}
