import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/dotted_border_btn.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/family_card_two.dart';

class EmployeeScreenPT1 extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const EmployeeScreenPT1({super.key, this.scaffoldKey});

  @override
  State<EmployeeScreenPT1> createState() => _EmployeeScreenPT1State();
}

class _EmployeeScreenPT1State extends State<EmployeeScreenPT1> {
  TextEditingController companyName = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController empCode = TextEditingController();
  TextEditingController organization = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController landline = TextEditingController();
  TextEditingController contactPerson = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController empDept = TextEditingController();
  TextEditingController panCard = TextEditingController();
  TextEditingController aadharCard = TextEditingController();
  TextEditingController doj = TextEditingController();
  TextEditingController hrName = TextEditingController();
  TextEditingController dol = TextEditingController();
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Employee",
        scaffoldKey: widget.scaffoldKey,
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFieldWithName(
                controller: companyName,
                ddName: 'Company Name',
                hintText: 'Company Name',
              ),
              SizedBox(height: 15),
              Text("Personal Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: name,
                ddName: 'Name',
                hintText: 'Name',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: empCode,
                ddName: 'Employee Code',
                hintText: 'Employee Code',
              ),
              CustomTextFieldWithName(
                controller: organization,
                ddName: 'Organization',
                hintText: 'Organization',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: dob,
                ddName: "DOB",
                hintText: "DOB",
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: gender,
                ddName: 'Gender',
                hintText: 'Gender',
              ),
              SizedBox(height: 15),
              Text("Contact Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: mobile,
                ddName: 'Mobile No',
                hintText: 'Mobile No',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: landline,
                ddName: 'Landline',
                hintText: 'Landline',
              ),
              CustomTextFieldWithName(
                controller: contactPerson,
                ddName: 'Contact Person',
                hintText: 'Contact Person',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: city,
                ddName: "City",
                hintText: "City",
              ),
              Text("Other Details", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              CustomTextFieldWithName(
                controller: empDept,
                ddName: 'Employee Department',
                hintText: 'Employee Department',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: panCard,
                ddName: 'Pan Card',
                hintText: 'Pan Card',
              ),
              CustomTextFieldWithName(
                controller: aadharCard,
                ddName: 'Aadhar Card',
                hintText: 'Aadhar Card',
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: doj,
                ddName: "DOJ",
                hintText: "DOJ",
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: hrName,
                ddName: "HR Name",
                hintText: "HR Name",
              ),
              SizedBox(height: 10),
              CustomTextFieldWithName(
                controller: dol,
                ddName: "DOL",
                hintText: "DOL",
              ),
              SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Status", style: AppTextTheme.subItemTitle),

                  Switch(
                    value: light,
                    activeColor: AppTextTheme.primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("EA", style: AppTextTheme.subItemTitle),

                  Switch(
                    value: light,
                    activeColor: AppTextTheme.primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        light = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text("Document", style: AppTextTheme.subTitle),
              SizedBox(height: 10),

              DottedBorderBtn(
                label: "Document",
                iconPath: 'assets/icons/download_green.svg',
                height: 60,
              ),
              SizedBox(height: 15),

              DottedBorderBtn(
                label: "Document",
                iconPath: 'assets/icons/download_green.svg',
                height: 60,
              ),
              SizedBox(height: 15),
              Text("Employee Dependent", style: AppTextTheme.subTitle),
              SizedBox(height: 5),
              FamilyCardTwo(
                name: "Kaushal Patel",
                dob: "12 Jul 2000",
                dependent: "Son",
                doc: "12 Jul 2000",
              ),

              FamilyCardTwo(
                name: "Kaushal Patel",
                dob: "12 Jul 2000",
                dependent: "Son",
                doc: "12 Jul 2000",
              ),

              FamilyCardTwo(
                name: "Kaushal Patel",
                dob: "12 Jul 2000",
                dependent: "Son",
                doc: "12 Jul 2000",
              ),

              FamilyCardTwo(
                name: "Kaushal Patel",
                dob: "12 Jul 2000",
                dependent: "Son",
                doc: "12 Jul 2000",
              ),

              FamilyCardTwo(
                name: "Kaushal Patel",
                dob: "12 Jul 2000",
                dependent: "Son",
                doc: "12 Jul 2000",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
