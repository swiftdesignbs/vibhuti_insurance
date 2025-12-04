import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';

class HomeSampleScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const HomeSampleScreen({super.key, this.scaffoldKey});

  @override
  State<HomeSampleScreen> createState() => _HomeSampleScreenState();
}

class _HomeSampleScreenState extends State<HomeSampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Home Sample Collection", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
          icon: SvgPicture.asset('assets/icons/menu.svg', height: 16, width: 16),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text("Home Sample Collection Screen", style: AppTextTheme.pageTitle),
        ),
      ),
    );
  }
}
