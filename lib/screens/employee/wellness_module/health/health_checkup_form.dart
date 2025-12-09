import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class HealthCheckUpFormScreen extends StatefulWidget {
  const HealthCheckUpFormScreen({super.key});

  @override
  State<HealthCheckUpFormScreen> createState() =>
      _HealthCheckUpFormScreenState();
}

class _HealthCheckUpFormScreenState extends State<HealthCheckUpFormScreen> {
  final controllers = Get.put(StateController());

  bool isChecked = false;
  TextEditingController employeeCodeController = TextEditingController();
  TextEditingController employeeNameController = TextEditingController();
  TextEditingController emailIDController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController policyTypeController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();
  TextEditingController patientNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController relationController = TextEditingController();
  TextEditingController typesNServices = TextEditingController();
  TextEditingController appointmentDate1Controller = TextEditingController();
  TextEditingController appointmentDate2Controller = TextEditingController();
  TextEditingController hospitalCenterName = TextEditingController();
  TextEditingController hospitalAddress = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController availablePlans = TextEditingController();
  TextEditingController planCost = TextEditingController();
  @override
  void initState() {
    super.initState();
    print("Health Check-up Form Screen : ${controllers.authUserProfileData}");

    // Auto-fill the form with user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoFillFormData();
    });
  }

  void _autoFillFormData() {
    if (controllers.authUserProfileData.isNotEmpty) {
      setState(() {
        // Employee Code
        employeeCodeController.text =
            controllers.authUserProfileData['employeeCode']?.toString() ?? '';

        // Employee Name
        String firstName =
            controllers.authUserProfileData['firstName']?.toString() ?? '';
        String lastName =
            controllers.authUserProfileData['lastName']?.toString() ?? '';
        employeeNameController.text = '$firstName $lastName'.trim();

        // Email ID
        emailIDController.text =
            controllers.authUserProfileData['emailAddress']?.toString() ?? '';

        // Mobile No.
        mobileNoController.text =
            controllers.authUserProfileData['mobileNo']?.toString() ?? '';

        // Gender
        genderController.text =
            controllers.authUserProfileData['genderName']?.toString() ?? '';

        // City
        cityController.text =
            controllers.authUserProfileData['cityName']?.toString() ?? '';

        // Pincode
        pincodeController.text =
            controllers.authUserProfileData['pinCode']?.toString() ?? '';

        // Policy Type (you might need to get this from another API)
        // For now, we can set a default or leave empty

        // Patient/Member Name (default to employee name)
        patientNameController.text = '$firstName $lastName'.trim();

        // Age (calculate from dateOfBirth if available)
        if (controllers.authUserProfileData['dateOfBirth'] != null) {
          try {
            String dobStr = controllers.authUserProfileData['dateOfBirth']
                .toString();
            // Parse date and calculate age
            // This is a simplified version - you might need proper date parsing
            if (dobStr.contains('-')) {
              List<String> parts = dobStr.split('-');
              if (parts.length >= 3) {
                int? birthYear = int.tryParse(parts[2]);
                if (birthYear != null) {
                  int currentYear = DateTime.now().year;
                  int age = currentYear - birthYear;
                  ageController.text = age.toString();
                }
              }
            }
          } catch (e) {
            print("Error calculating age: $e");
          }
        }
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Health Check-up Form", style: AppTextTheme.pageTitle),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextFieldWithName(
                keyboardType: TextInputType.number,
                controller: employeeCodeController,
                hintText: "Text",
                ddName: 'Employee Code',
                readOnly: true,
              ),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,
                readOnly: true,

                controller: employeeNameController,
                hintText: "Text",
                ddName: 'Employee Name',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.emailAddress,
                readOnly: true,

                controller: emailIDController,
                hintText: "Text",
                ddName: 'Email ID',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.phone,
                readOnly: true,

                controller: mobileNoController,
                hintText: "Text",
                ddName: 'Mobile No.',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: policyTypeController,
                hintText: "Text",
                ddName: 'Policy Type',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: policyNoController,
                hintText: "Text",
                ddName: 'Policy No.',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: patientNameController,
                hintText: "Text",
                ddName: 'Patient or Member Name',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.number,

                controller: ageController,
                hintText: "Text",
                ddName: 'Age',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: genderController,
                hintText: "Text",
                ddName: 'Gender',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: relationController,
                hintText: "Text",
                ddName: 'Relation',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: typesNServices,
                hintText: "Text",
                ddName: 'Type Of Services',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: appointmentDate1Controller,
                hintText: "DD/MM/YYYY",
                ddName: 'New Appointment Date 1',
                suffixIcon: "assets/icons/calender.svg",
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: appointmentDate2Controller,
                hintText: "DD/MM/YYYY",
                ddName: 'New Appointment Date 2',
                suffixIcon: "assets/icons/calender.svg",
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: hospitalCenterName,
                hintText: "Text",
                ddName: 'Hospital or Daignostics Centre Name',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: hospitalAddress,
                hintText: "Text",
                ddName: 'Hospital Address',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: pincodeController,
                hintText: "Text",
                ddName: 'Pincode',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: cityController,
                hintText: "Text",
                ddName: 'City',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: availablePlans,
                hintText: "Text",
                ddName: 'Available Plans',
              ),
              SizedBox(height: 5),

              CustomTextFieldWithName(
                controller: planCost,
                hintText: "Text",
                ddName: 'Plan Cost',
              ),

              const SizedBox(height: 20),

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
                    child: Text(
                      "By submitting this form, I/We accept and give my/our consent "
                      "to share the personal information which will be used by the "
                      "third-party vendor for the subject matter of insurance.\n\n"
                      "On sharing the information Vibhuti Insurance Brokers and its "
                      "employees will not be responsible for any misuse of the data.",
                      style: AppTextTheme.paragraph.copyWith(
                        fontSize: 13.5,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),
              Buttons(
                onPressed: () {},
                ddName: "Proceed To Book",

                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
