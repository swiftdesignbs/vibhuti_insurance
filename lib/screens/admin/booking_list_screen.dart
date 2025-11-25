import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';

class AdminBookingListScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const AdminBookingListScreen({super.key, this.scaffoldKey});

  @override
  State<AdminBookingListScreen> createState() => _AdminBookingListScreenState();
}

class _AdminBookingListScreenState extends State<AdminBookingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Booking List",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: Center(child: Text("Booking List")),
    );
  }
}
