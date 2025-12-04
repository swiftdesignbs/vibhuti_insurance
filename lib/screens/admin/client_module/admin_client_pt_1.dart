import 'package:flutter/material.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/app_bar.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class AdminClientPt1 extends StatefulWidget {
  final Map<String, dynamic> client; // Make it required and typed
  const AdminClientPt1({super.key, required this.client});

  @override
  State<AdminClientPt1> createState() => _AdminClientPt1State();
}

class _AdminClientPt1State extends State<AdminClientPt1> {
  // All controllers
  late final TextEditingController parentCompnay;
  late final TextEditingController companyCode;
  late final TextEditingController companyCode1;
  late final TextEditingController companyName;
  late final TextEditingController industry;
  late final TextEditingController dob;
  late final TextEditingController level1;
  late final TextEditingController level2;
  late final TextEditingController panCard;
  late final TextEditingController adharCard;
  late final TextEditingController gstNo;
  late final TextEditingController contactPerson;
  late final TextEditingController address;
  late final TextEditingController city;
  late final TextEditingController mobile;
  late final TextEditingController landline;
  late final TextEditingController paidDate;
  late final TextEditingController emailId;
  late final TextEditingController status;

  bool employeeCodeLogin = false;
  bool mobileLogin = false;
  bool emailLogin = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with data safely
    parentCompnay = TextEditingController(
      text: widget.client['parentCompany'] ?? '',
    );
    companyCode = TextEditingController(
      text: widget.client['companyCode'] ?? '',
    );
    companyCode1 = TextEditingController(
      text: widget.client['companyCode1'] ?? '',
    );
    companyName = TextEditingController(
      text: widget.client['companyName'] ?? '',
    );
    industry = TextEditingController(text: widget.client['industry'] ?? '');
    dob = TextEditingController(text: widget.client['dob'] ?? '');
    level1 = TextEditingController(text: widget.client['level1'] ?? '');
    level2 = TextEditingController(text: widget.client['level2'] ?? '');
    panCard = TextEditingController(text: widget.client['panCard'] ?? '');
    adharCard = TextEditingController(text: widget.client['adharCard'] ?? '');
    gstNo = TextEditingController(text: widget.client['gstNo'] ?? '');
    contactPerson = TextEditingController(
      text: widget.client['contactPerson'] ?? '',
    );
    address = TextEditingController(text: widget.client['address'] ?? '');
    city = TextEditingController(text: widget.client['city'] ?? '');
    mobile = TextEditingController(text: widget.client['mobile'] ?? '');
    landline = TextEditingController(text: widget.client['landline'] ?? '');
    paidDate = TextEditingController(text: widget.client['paidDate'] ?? '');
    emailId = TextEditingController(text: widget.client['emailId'] ?? '');
    status = TextEditingController(text: widget.client['status'] ?? '');

    // Optional: Set initial switch values from data
    employeeCodeLogin = widget.client['employeeCodeLogin'] == true;
    mobileLogin = widget.client['mobileLogin'] == true;
    emailLogin = widget.client['emailLogin'] == true;
  }

  @override
  void dispose() {
    // Always dispose controllers
    parentCompnay.dispose();
    companyCode.dispose();
    companyCode1.dispose();
    companyName.dispose();
    industry.dispose();
    dob.dispose();
    level1.dispose();
    level2.dispose();
    panCard.dispose();
    adharCard.dispose();
    gstNo.dispose();
    contactPerson.dispose();
    address.dispose();
    city.dispose();
    mobile.dispose();
    landline.dispose();
    paidDate.dispose();
    emailId.dispose();
    status.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUtils.buildCommonAppBar(
        context: context,
        screenTitle: "Client Details",
        showImplyingIcon: true,
        showWelcomeText: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company Details", style: AppTextTheme.subTitle),
            const SizedBox(height: 12),

            CustomTextFieldWithName(
              controller: parentCompnay,
              ddName: 'Parent Company',
              hintText: 'Parent Company',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: companyCode,
              ddName: 'Company Code',
              hintText: 'Company Code',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: companyName,
              ddName: 'Company Name',
              hintText: 'Company Name',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: industry,
              ddName: 'Industry',
              hintText: 'Industry',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: level1,
              ddName: 'Level 1',
              hintText: 'Level 1',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: level2,
              ddName: 'Level 2',
              hintText: 'Level 2',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: panCard,
              ddName: 'PAN Card',
              hintText: 'Enter PAN',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: adharCard,
              ddName: 'Aadhar Card',
              hintText: 'Enter Aadhar',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: gstNo,
              ddName: 'GST No.',
              hintText: 'Enter GST No.',
            ),

            const SizedBox(height: 24),
            Text("Contact Details", style: AppTextTheme.subTitle),
            const SizedBox(height: 12),

            CustomTextFieldWithName(
              controller: contactPerson,
              ddName: 'Contact Person',
              hintText: 'Name',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: address,
              ddName: 'Address',
              hintText: 'Address',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: city,
              ddName: 'City',
              hintText: 'City',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: mobile,
              ddName: 'Mobile',
              hintText: 'Mobile Number',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: landline,
              ddName: 'Landline',
              hintText: 'Landline Number',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: emailId,
              ddName: 'Email ID',
              hintText: 'email@example.com',
            ),
            const SizedBox(height: 12),
            CustomTextFieldWithName(
              controller: status,
              ddName: 'Status',
              hintText: 'Status',
            ),

            const SizedBox(height: 24),
            Text("Login Configuration", style: AppTextTheme.subTitle),
            const SizedBox(height: 16),

            CustomTextFieldWithName(
              controller: companyCode1,
              ddName: 'Login ID',
              hintText: 'Login ID',
            ),

            const SizedBox(height: 20),
            _buildSwitchTile(
              "Employee Code",
              employeeCodeLogin,
              (val) => setState(() => employeeCodeLogin = val),
            ),
            _buildSwitchTile(
              "Mobile No",
              mobileLogin,
              (val) => setState(() => mobileLogin = val),
            ),
            _buildSwitchTile(
              "Email ID",
              emailLogin,
              (val) => setState(() => emailLogin = val),
            ),

            const SizedBox(height: 32),
            Buttons(
              onPressed: () {},
              ddName: "Save Changes",
              width: double.infinity,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextTheme.paragraph.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        Switch(
          value: value,
          activeThumbColor: AppTextTheme.primaryColor,
          inactiveThumbColor: Colors.white,
          activeTrackColor: AppTextTheme.primaryColor.withOpacity(0.5),
          inactiveTrackColor: Colors.grey.withOpacity(0.5),
          splashRadius: 0,

          onChanged: onChanged,
        ),
      ],
    );
  }
}
