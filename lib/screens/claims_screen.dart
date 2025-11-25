import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/screens/hospital_and_expenses.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class ClaimsScreen extends StatefulWidget {
  const ClaimsScreen({super.key});

  @override
  State<ClaimsScreen> createState() => _ClaimsScreenState();
}

class _ClaimsScreenState extends State<ClaimsScreen> {
  TextEditingController employeeName = TextEditingController();
  TextEditingController employeeCode = TextEditingController();
  TextEditingController policyType = TextEditingController();
  TextEditingController policyNo = TextEditingController();
  TextEditingController claimType = TextEditingController();
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
                  Text('Claims', style: AppTextTheme.pageTitle),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10),
            CustomTextFieldWithName(
              controller: employeeName,
              ddName: 'Employee Name',
            ),
            SizedBox(height: 5),

            CustomTextFieldWithName(
              controller: employeeCode,
              ddName: 'Employee Code',
              suffixIcon: "assets/icons/down_icon.svg",
            ),
            SizedBox(height: 5),

            CustomTextFieldWithName(
              controller: employeeCode,
              ddName: 'Policy Type',
              suffixIcon: "assets/icons/down_icon.svg",
            ),
            SizedBox(height: 5),

            CustomTextFieldWithName(
              controller: employeeCode,
              ddName: 'Policy No',
              suffixIcon: "assets/icons/down_icon.svg",
            ),
            SizedBox(height: 5),
            CustomTextFieldWithName(
              controller: employeeCode,
              ddName: 'Claim Type',
              suffixIcon: "assets/icons/down_icon.svg",
            ),
            Spacer(),
            Buttons(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HospitalAndExpensesScreen(),
                  ),
                );
              },
              ddName: "Next",
              width: double.infinity,
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
