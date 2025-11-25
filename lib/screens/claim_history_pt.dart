import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';

class ClaimHistoryPT1 extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const ClaimHistoryPT1({super.key, this.scaffoldKey});

  @override
  State<ClaimHistoryPT1> createState() => _ClaimHistoryPT1State();
}

class _ClaimHistoryPT1State extends State<ClaimHistoryPT1> {
  TextEditingController policyNo = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController sumInsured = TextEditingController();
  TextEditingController balanceSumInsured = TextEditingController();
  TextEditingController claimType = TextEditingController();
  TextEditingController payableNo = TextEditingController();
  TextEditingController tpaClaimNo = TextEditingController();
  TextEditingController dateOfAdmission = TextEditingController();
  TextEditingController dateOfDischarges = TextEditingController();
  TextEditingController ailment = TextEditingController();
  TextEditingController hospitalName = TextEditingController();
  TextEditingController hospitalCity = TextEditingController();
  TextEditingController claimAmt = TextEditingController();
  TextEditingController paidAmt = TextEditingController();
  TextEditingController paidDate = TextEditingController();
  TextEditingController chequeEftNo = TextEditingController();
  TextEditingController claimStatus = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Claim History",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextFieldWithName(
                controller: policyNo,
                ddName: 'Policy No',
                hintText: 'Policy No',
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
