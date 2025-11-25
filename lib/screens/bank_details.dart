import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/screens/bank_docs_details.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  TextEditingController accountNo = TextEditingController();
  TextEditingController reAccountNo = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankBranch = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController modalAccountNo = TextEditingController();
  TextEditingController modalReAccountNo = TextEditingController();
  TextEditingController modalIfscCode = TextEditingController();
  TextEditingController modalBankBranch = TextEditingController();
  TextEditingController modalBankName = TextEditingController();
  bool isChecked = false;

  late Timer _timer;
  int _remainingSeconds = 20 * 60; // 20 minutes

  void _showClaimSubmissionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.60 : 0.80;
        return FractionallySizedBox(
          heightFactor: sheetHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setModalState) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Claim Submission",
                              style: AppTextTheme.pageTitle,
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.grey[600]),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextFieldWithName(
                                  controller: modalAccountNo,
                                  ddName: 'Account No',
                                  hintText: 'Account No',
                                ),
                                SizedBox(height: 5),
                                CustomTextFieldWithName(
                                  controller: modalReAccountNo,
                                  ddName: 'Re-enter Account No',
                                  hintText: 'Re-enter Account No',
                                ),
                                SizedBox(height: 5),
                                CustomTextFieldWithName(
                                  controller: modalIfscCode,
                                  ddName: 'IFSC Code',
                                  hintText: 'IFSC Code',
                                ),
                                SizedBox(height: 5),
                                CustomTextFieldWithName(
                                  controller: modalBankBranch,
                                  ddName: 'Bank Branch',
                                  hintText: 'Bank Branch',
                                ),
                                SizedBox(height: 5),
                                CustomTextFieldWithName(
                                  controller: modalBankName,
                                  ddName: 'Bank Name',
                                  hintText: 'Bank Name',
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "Upload Cancel Cheque",
                                  style: AppTextTheme.subItemTitle,
                                ),
                                SizedBox(height: 10),

                                DottedBorderBtn(
                                  label: "Upload Document",
                                  iconPath: 'assets/icons/upload_icon.svg',
                                  height: 80,
                                ),
                                SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFC7C7),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.red,
                                          offset: const Offset(6, 6),
                                          blurRadius: 0,
                                        ),
                                      ],
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Disclaimer",
                                          style: AppTextTheme.subTitle.copyWith(
                                            color: Colors.black,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text:
                                                    "Upload Only Employee Bank Details. ",
                                                style: AppTextTheme.subItemTitle
                                                    .copyWith(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight
                                                          .bold, // <-- Bold here
                                                    ),
                                              ),
                                              TextSpan(
                                                text:
                                                    "Ensure the cheque, bank statement, or passbook is clear with the account holder’s name, account number, and IFSC code visible.",
                                                style: AppTextTheme.subItemTitle
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Buttons(
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      ); // 👈 Close the bottom sheet

                                      Future.delayed(
                                        const Duration(milliseconds: 200),
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const BankDocsDetails(),
                                            ),
                                          );
                                        },
                                      );
                                    },

                                    ddName: "Update",
                                    width: double.infinity,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = 1 - (_remainingSeconds / (20 * 60));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Bank Details', style: AppTextTheme.subTitle),
                  Text(
                    _formatTime(_remainingSeconds),
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Linear progress indicator
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                color: AppTextTheme.primaryColor,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldWithName(
                controller: accountNo,
                ddName: 'Account No',
                hintText: 'Account No',
              ),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: reAccountNo,
                ddName: 'Re-enter Account No',
                hintText: 'Re-enter Account No',
              ),
              CustomTextFieldWithName(
                controller: ifscCode,
                ddName: 'IFSC Code',
                hintText: 'IFSC Code',
              ),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: bankBranch,
                ddName: 'Bank Branch',
                hintText: 'Bank Branch',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: bankName,
                ddName: 'Bank Name',
                hintText: 'Bank Name',
              ),
              SizedBox(height: 5),
              Text("Upload Cancel Cheque", style: AppTextTheme.subItemTitle),
              SizedBox(height: 5),

              DottedBorderBtn(
                label: "Upload Document",
                iconPath: 'assets/icons/upload_icon.svg',
                height: 80,
              ),

              SizedBox(height: 5),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isChecked,
                    activeColor: AppTextTheme.primaryColor,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextTheme.paragraph.copyWith(
                          fontSize: 13.5,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                        children: [
                          const TextSpan(
                            text:
                                "Clicking on this will ensure the claim amount is credited to your provided bank details.\n\n"
                                "If the IFSC code doesn't retrieve the bank name and branch, please click ",
                          ),

                          TextSpan(
                            text: "Update/Add Bank Details",
                            style: TextStyle(
                              color: AppTextTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _showClaimSubmissionBottomSheet(context);
                              },
                          ),

                          const TextSpan(text: " to update your information."),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC7C7),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        offset: const Offset(6, 6),
                        blurRadius: 0,
                      ),
                    ],
                    border: Border.all(color: Colors.red, width: 1.5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Disclaimer",
                        style: AppTextTheme.subTitle.copyWith(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Upload Only Employee Bank Details. ",
                              style: AppTextTheme.subItemTitle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold, // <-- Bold here
                              ),
                            ),
                            TextSpan(
                              text:
                                  "Ensure the cheque, bank statement, or passbook is clear with the account holder’s name, account number, and IFSC code visible.",
                              style: AppTextTheme.subItemTitle.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Buttons(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BankDocsDetails(),
                      ),
                    );
                  },
                  ddName: "Next",
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: Text(
                    "Save",
                    style: AppTextTheme.buttonText.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppTextTheme.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
