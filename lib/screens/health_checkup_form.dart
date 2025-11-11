import 'package:flutter/material.dart';
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
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Health Check-up Form", style: AppTextTheme.pageTitle),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CustomTextFieldWithName(
                keyboardType: TextInputType.number,
                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Employee Code',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Employee Name',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.emailAddress,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Email ID',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.phone,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Mobile No.',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Policy Type',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Policy No.',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Patient or Member Name',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.number,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Age',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Gender',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Relation',
              ),
              CustomTextFieldWithName(
                keyboardType: TextInputType.text,

                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Type Of Services',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "DD/MM/YYYY",
                ddName: 'New Appointment Date 1',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "DD/MM/YYYY",
                ddName: 'New Appointment Date 2',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Hospital or Daignostics Centre Name',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Hospital Address',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Pincode',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'City',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
                hintText: "Text",
                ddName: 'Available Plans',
              ),
              CustomTextFieldWithName(
                controller: TextEditingController(),
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
