import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card_two.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class ClaimHistoryPt1 extends StatefulWidget {
  const ClaimHistoryPt1({super.key});

  @override
  State<ClaimHistoryPt1> createState() => _ClaimHistoryPt1State();
}

class _ClaimHistoryPt1State extends State<ClaimHistoryPt1> {
  TextEditingController policyNo = TextEditingController();
  TextEditingController patientName = TextEditingController();
  TextEditingController sumInsured = TextEditingController();
  TextEditingController balanceSumInsured = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController claimType = TextEditingController();
  TextEditingController payableTo = TextEditingController();
  TextEditingController tpaClaimNo = TextEditingController();
  TextEditingController dateOfAdmission = TextEditingController();
  TextEditingController dateOfDischarge = TextEditingController();
  TextEditingController ailment = TextEditingController();
  TextEditingController hospitalName = TextEditingController();
  TextEditingController hospitalCity = TextEditingController();
  TextEditingController claimAmt = TextEditingController();
  TextEditingController paidAmt = TextEditingController();
  TextEditingController paidDate = TextEditingController();
  TextEditingController chequeEFT = TextEditingController();
  TextEditingController claimStatus = TextEditingController();

  bool light = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Claim history",
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Personal Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: policyNo,
                ddName: 'Policy No.',
                hintText: 'Policy No.',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: patientName,
                ddName: 'Patient Name',
                hintText: 'Patient Name',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: sumInsured,
                ddName: 'Sum Insured',
                hintText: 'Sum Insured',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: balanceSumInsured,
                ddName: 'Balance Sum Insured',
                hintText: 'Balance Sum Insured',
              ),
              SizedBox(height: 15),
              Text("Contact Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: claimType,
                ddName: 'Claim Type',
                hintText: 'Claim Type',
              ),

              SizedBox(height: 10),

              CustomTextFieldWithName(
                controller: payableTo,
                ddName: 'Payable To',
                hintText: 'Payable To',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: tpaClaimNo,
                ddName: 'TPA Claim No.',
                hintText: 'TPA Claim No.',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: dateOfAdmission,
                ddName: 'Date of Admission',
                hintText: 'Date of Admission',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: dateOfDischarge,
                ddName: 'Date of Discharge',
                hintText: 'Date of Discharge',
              ),
              Text("Other Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: ailment,
                ddName: 'Ailment',
                hintText: 'Ailment',
              ),
              SizedBox(height: 15),
              Text("Hospital Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: hospitalName,
                ddName: 'Hospital Name',
                hintText: 'Hospital Name',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: hospitalCity,
                ddName: 'Hospital City',
                hintText: 'Hospital City',
              ),
              SizedBox(height: 15),
              Text("Payment Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: claimAmt,
                ddName: 'Claim Amount',
                hintText: 'Claim Amount',
              ),
              SizedBox(height: 10),

              CustomTextFieldWithName(
                controller: paidAmt,
                ddName: 'Paid Amount',
                hintText: 'Paid Amount',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: chequeEFT,
                ddName: "Cheque EFT No.",
                hintText: "Cheque EFT No.",
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: claimStatus,
                ddName: "Claim Status",
                hintText: "Claim Status",
              ),
              SizedBox(height: 10),

              Text("Document", style: AppTextTheme.subTitle),
              SizedBox(height: 10),
              Text(
                "Claim Document",
                style: AppTextTheme.subItemTitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              DottedBorderBtn(
                label: "Document",
                iconPath: 'assets/icons/download_green.svg',
                height: 60,
              ),
              SizedBox(height: 15),
              Text(
                "Approval Letter",
                style: AppTextTheme.subItemTitle.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 10),
              DottedBorderBtn(
                label: "Approval Letter",
                iconPath: 'assets/icons/download_green.svg',
                height: 60,
              ),
              SizedBox(height: 15),
              Buttons(onPressed: () {}, ddName: "Save", width: double.infinity),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
