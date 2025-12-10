import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibhuti_insurance_mobile_app/alerts/toast.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card_two.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';
import 'package:http/http.dart' as http;

class ClaimHistoryPt1 extends StatefulWidget {
  final Map<String, dynamic> claimDetails;

  const ClaimHistoryPt1({super.key, required this.claimDetails});

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
  bool isDownloading = false;

  bool light = true;
  bool _isLoading = true;
  bool _isEmpty = false;
  bool isDownloadingDocs = false;
  bool isDownloadingLetter = false;

  String docsUrl = "";
  String letterUrl = "";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    setState(() {
      _isLoading = true;
    });

    final data = widget.claimDetails;

    if (data.isEmpty) {
      setState(() {
        _isEmpty = true;
        _isLoading = false;
      });
      return;
    }

    policyNo.text = data["POLICY_NUMBER"] ?? "";
    patientName.text = data["PATIENT_NAME"] ?? "";
    sumInsured.text = data["SUM_INSURED"] ?? "";
    balanceSumInsured.text = data["BALANCE_SUM_INSURED"] ?? "";
    dob.text = data["PATIENT_DOB"] ?? "";
    claimType.text = data["CLAIM_TYPE"] ?? "";
    payableTo.text = data["TYPE_OF_CLAIM"] ?? "";
    tpaClaimNo.text = data["TPA_CLAIM_NO"] ?? "";
    dateOfAdmission.text = data["DATE_OF_ADMISSION"] ?? "";
    dateOfDischarge.text = data["DATE_OF_DISCHARGE"] ?? "";
    ailment.text = data["AILMENT"] ?? "";
    hospitalName.text = data["HOSPITAL_NAME"] ?? "";
    hospitalCity.text = data["HOSPITAL_CITY"] ?? "";
    claimAmt.text = data["CLAIM_AMOUNT"] ?? "";
    paidAmt.text = data["PAID_AMOUNT"] ?? "";
    paidDate.text = data["PAID_DATE"] ?? "";
    chequeEFT.text = data["CHEQUE_EFT_NO"] ?? "";
    claimStatus.text = data["CLAIM_STATUS"] ?? "";
    docsUrl = data["DOCS_URL"] ?? "";
    letterUrl = data["LETTER_URL"] ?? "";
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> downloadFile(
    String url,
    String fileName,
    VoidCallback onStart,
    VoidCallback onComplete,
  ) async {
    try {
      onStart(); // mark as downloading
      // Ask storage permission (Android 13 lower)
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }

      final response = await http.get(Uri.parse(url));
      await Future.delayed(Duration(seconds: 3));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        final directory = Directory("/storage/emulated/0/Download");
        final filePath = "${directory.path}/$fileName";
        final file = File(filePath);

        await file.writeAsBytes(bytes);

        print("📁 File saved → $filePath");

        CustomToast.show(
          context: context,
          message: "File downloaded to Downloads folder",
          success: true,
        );
      } else {
        CustomToast.show(
          context: context,
          message: "Failed to download file",
          success: false,
        );
      }
    } catch (e) {
      print("❌ Download error: $e");

      CustomToast.show(
        context: context,
        message: "Something went wrong",
        success: false,
      );
    } finally {
      onComplete(); // stop loading
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Claim history",
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: AppTextTheme.primaryColor,
              ),
            )
          : _isEmpty
          ? Center(
              child: Text(
                "No claim details found",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : SingleChildScrollView(
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
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: patientName,
                      ddName: 'Patient Name',
                      hintText: 'Patient Name',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: sumInsured,
                      ddName: 'Sum Insured',
                      hintText: 'Sum Insured',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: balanceSumInsured,
                      ddName: 'Balance Sum Insured',
                      hintText: 'Balance Sum Insured',
                      readOnly: true,
                    ),
                    SizedBox(height: 15),
                    Text("Contact Details", style: AppTextTheme.subTitle),
                    SizedBox(height: 5),

                    CustomTextFieldWithName(
                      controller: claimType,
                      ddName: 'Claim Type',
                      hintText: 'Claim Type',
                      readOnly: true,
                    ),

                    SizedBox(height: 10),

                    CustomTextFieldWithName(
                      controller: payableTo,
                      ddName: 'Payable To',
                      hintText: 'Payable To',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: tpaClaimNo,
                      ddName: 'TPA Claim No.',
                      hintText: 'TPA Claim No.',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: dateOfAdmission,
                      ddName: 'Date of Admission',
                      hintText: 'Date of Admission',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: dateOfDischarge,
                      ddName: 'Date of Discharge',
                      hintText: 'Date of Discharge',
                      readOnly: true,
                    ),
                    Text("Other Details", style: AppTextTheme.subTitle),
                    SizedBox(height: 5),
                    CustomTextFieldWithName(
                      controller: ailment,
                      ddName: 'Ailment',
                      hintText: 'Ailment',
                      readOnly: true,
                    ),
                    SizedBox(height: 15),
                    Text("Hospital Details", style: AppTextTheme.subTitle),
                    SizedBox(height: 5),

                    CustomTextFieldWithName(
                      controller: hospitalName,
                      ddName: 'Hospital Name',
                      hintText: 'Hospital Name',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: hospitalCity,
                      ddName: 'Hospital City',
                      hintText: 'Hospital City',
                      readOnly: true,
                    ),
                    SizedBox(height: 15),
                    Text("Payment Details", style: AppTextTheme.subTitle),
                    SizedBox(height: 5),

                    CustomTextFieldWithName(
                      controller: claimAmt,
                      ddName: 'Claim Amount',
                      hintText: 'Claim Amount',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),

                    CustomTextFieldWithName(
                      controller: paidAmt,
                      ddName: 'Paid Amount',
                      hintText: 'Paid Amount',
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: chequeEFT,
                      ddName: "Cheque EFT No.",
                      hintText: "Cheque EFT No.",
                      readOnly: true,
                    ),
                    SizedBox(height: 10),
                    CustomTextFieldWithName(
                      controller: claimStatus,
                      ddName: "Claim Status",
                      hintText: "Claim Status",
                      readOnly: true,
                    ),
                    SizedBox(height: 10),

                    Text("Document", style: AppTextTheme.subTitle),
                    SizedBox(height: 10),

                    if (docsUrl.isNotEmpty) ...[
                      Text(
                        "Claim Document",
                        style: AppTextTheme.subItemTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),

                      DottedBorderBtn(
                        label: isDownloadingDocs
                            ? "Downloading..."
                            : "Document",
                        iconPath: 'assets/icons/download_green.svg',
                        height: 60,
                        onPressed: isDownloading
                            ? null
                            : () async {
                                setState(() => isDownloading = true);
                                await downloadFile(
                                  docsUrl,
                                  "ClaimDocument.pdf",
                                  () {
                                    setState(() => isDownloadingDocs = true);
                                  },
                                  () {
                                    setState(() => isDownloadingDocs = false);
                                  },
                                );
                                // After download completes
                                setState(() => isDownloading = false);
                              },
                      ),
                    ],
                    SizedBox(height: 20),
                    if (letterUrl.isNotEmpty) ...[
                      Text(
                        "Approval Letter",
                        style: AppTextTheme.subItemTitle.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),

                      DottedBorderBtn(
                        label: isDownloadingLetter
                            ? "Downloading..."
                            : "Approval Letter",
                        iconPath: 'assets/icons/download_green.svg',
                        height: 60,
                        // Disable button while downloading
                        onPressed: isDownloading
                            ? null
                            : () async {
                                setState(() => isDownloading = true);
                                await downloadFile(
                                  letterUrl,
                                  "ApprovalLetter.pdf",
                                  () {
                                    setState(() => isDownloadingLetter = true);
                                  },
                                  () {
                                    setState(() => isDownloadingLetter = false);
                                  },
                                );

                                // After download completes
                                setState(() => isDownloading = false);
                              },
                      ),
                    ],

                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
