import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/claim_history/claim_history.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class BankDocsDetails extends StatefulWidget {
  const BankDocsDetails({super.key});

  @override
  State<BankDocsDetails> createState() => _BankDocsDetailsState();
}

class _BankDocsDetailsState extends State<BankDocsDetails> {
  bool isSingleFileSelected = false;
  bool isChecked = false;
  late Timer _timer;
  int _remainingSeconds = 20 * 60; // 20 minutes
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                StatefulBuilder(
                  builder: (context, setStateCheckbox) {
                    return Checkbox(
                      value: isSingleFileSelected,
                      activeColor: AppTextTheme.primaryColor,
                      onChanged: (value) {
                        setStateCheckbox(() {
                          isSingleFileSelected = value!;
                        });
                      },
                    );
                  },
                ),
                Text(
                  "Single File Upload",
                  style: AppTextTheme.subTitle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Buttons(onPressed: () {}, ddName: "Next", width: double.infinity),

            const SizedBox(height: 20),
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
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Document For Health Checkup Claim",
                style: AppTextTheme.subTitle,
              ),
              SizedBox(height: 20),
              Text("Health Report", style: AppTextTheme.subItemTitle),
              SizedBox(height: 10),

              DottedBorderBtn(
                label: "Upload Document",
                iconPath: 'assets/icons/upload_icon.svg',
                height: 80,
              ),

              SizedBox(height: 10),
              Text("Invoice of Report", style: AppTextTheme.subItemTitle),
              SizedBox(height: 10),

              DottedBorderBtn(
                label: "Upload Document",
                iconPath: 'assets/icons/upload_icon.svg',
                height: 80,
              ),

              SizedBox(height: 10),
              Text(
                "Prescription if any for Report",
                style: AppTextTheme.subItemTitle,
              ),
              SizedBox(height: 10),

              DottedBorderBtn(
                label: "Upload Document",
                iconPath: 'assets/icons/upload_icon.svg',
                height: 80,
              ),

              SizedBox(height: 10),
              Text("Payment Receipt", style: AppTextTheme.subItemTitle),
              SizedBox(height: 10),

              DottedBorderBtn(
                label: "Upload Document",
                iconPath: 'assets/icons/upload_icon.svg',
                height: 80,
              ),

              SizedBox(height: 10),
              Text(
                "Other (If any other Important document attached here)",
                style: AppTextTheme.subItemTitle,
              ),
              SizedBox(height: 10),

              DottedBorderBtn(
                label: "Upload Document",
                iconPath: 'assets/icons/upload_icon.svg',
                height: 80,
              ),
              SizedBox(height: 10),

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
                                // _showClaimSubmissionBottomSheet(context);
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
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(6, 6),
                        blurRadius: 0,
                      ),
                    ],
                    border: Border.all(color: Colors.red, width: 1.5),
                  ),
                  child: Column(
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
                      const SizedBox(height: 10),

                      bulletPoints(
                        "Please scan and upload all medical claim documents using the document uploader. You can either:",
                      ),
                      bulletPoints(
                        "Combine Multiple documents into a single PDF (Single Upload).",
                      ),
                      bulletPoints("Accepted file formats: .Pdf, .Jpg, .Png"),
                      bulletPoints("File size limit: 0MB to 25MB"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget bulletPoints(String text) {
  final boldWords = [
    "Combine Multiple",
    "Single Upload",
    ".Pdf",
    ".Jpg",
    ".Png",
    "0MB to 25MB",
  ];

  List<TextSpan> spans = [];
  String workingText = text;

  for (String boldWord in boldWords) {
    if (workingText.contains(boldWord)) {
      final parts = workingText.split(boldWord);
      spans.add(TextSpan(text: parts[0])); // normal

      spans.add(
        TextSpan(
          text: boldWord,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

      workingText = parts.length > 1 ? parts[1] : "";
    }
  }

  // remaining text
  if (workingText.isNotEmpty) {
    spans.add(TextSpan(text: workingText));
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("•  ", style: TextStyle(fontSize: 16, height: 1)),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTextTheme.paragraph.copyWith(color: Colors.black87),
              children: spans,
            ),
          ),
        ),
      ],
    ),
  );
}
