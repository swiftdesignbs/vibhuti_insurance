import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/aes_encryption.dart';
import 'package:vibhuti_insurance_mobile_app/utils/api_service.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/utils/constant.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_dropdown.dart';
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
  TextEditingController typesNServices = TextEditingController();
  TextEditingController appointmentDate1Controller = TextEditingController();
  TextEditingController appointmentDate2Controller = TextEditingController();
  TextEditingController hospitalCenterName = TextEditingController();
  TextEditingController hospitalAddress = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController availablePlans = TextEditingController();
  TextEditingController planCost = TextEditingController();
  TextEditingController ageController = TextEditingController();

  bool isPolicyTypeLoading = false;
  bool isPolicyNumberLoading = false;
  bool isDependentLoading = false;

  List<String> policyTypeList = [];
  List<Map<String, dynamic>> policyNumberList = [];
  List<Map<String, dynamic>> dependentList = [];

  String selectedPolicyType = "";
  String selectedPolicyNumber = "";
  String selectedPolicyInputId = "";
  String selectedRelation = "";
  String selectedPatientName = "";
  String selectedGender = "";

  // Helper methods to convert to List<String>
  List<String> getPolicyNumberOptions() {
    return policyNumberList
        .map((item) => item['PolicyNo']?.toString() ?? "")
        .where((item) => item.isNotEmpty)
        .toList();
  }

  List<String> getRelationOptions() {
    return dependentList
        .map((item) => item['RelationName']?.toString() ?? "")
        .where((item) => item.isNotEmpty)
        .toList();
  }

  List<String> getPatientNameOptions() {
    return dependentList
        .map((item) => item['DependentName']?.toString() ?? "")
        .where((item) => item.isNotEmpty)
        .toList();
  }

  Future<void> loadPolicyTypes() async {
    if (!mounted) return;

    setState(() {
      isPolicyTypeLoading = true;
    });

    try {
      final types = await fetchPolicyTypes();
      print("Loaded policy types: $types");

      if (!mounted) return;

      setState(() {
        policyTypeList = types;
        isPolicyTypeLoading = false;
      });
    } catch (e) {
      print("Error loading policy types: $e");
      if (!mounted) return;
      setState(() {
        isPolicyTypeLoading = false;
      });
    }
  }

  Future<List<String>> fetchPolicyTypes() async {
    final token = controllers.authToken.toString();
    print("token : $token");

    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return [];
    }

    final employeeId =
        controllers.authUserProfileData['employeeId']?.toString() ?? "";

    if (employeeId.isEmpty) {
      print("Employee ID not found in auth data");
      return [];
    }

    print("Employee ID: $employeeId");

    final String url =
        "$baseUrl/api/Account/GetEmployeePolicyType?EmployeeID=$employeeId";
    print("url : $url");

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        String encrypted = response.body.trim();
        if (encrypted.startsWith('"') && encrypted.endsWith('"')) {
          encrypted = encrypted.substring(1, encrypted.length - 1);
        }

        final decrypted = AesEncryption.decryptAES(encrypted);
        print("Decrypted raw: $decrypted");

        if (decrypted.startsWith("Decryption Error")) {
          print("decryption error: $decrypted");
          return [];
        }

        final decoded = jsonDecode(decrypted);
        print("decoded full response: $decoded");

        if (decoded["IsError"] == true) {
          print("API returned error: ${decoded["ErrorMessage"]}");
          return [];
        }

        if (decoded["Result"] == null) {
          print("Result is null");
          return [];
        }

        final result = decoded["Result"];
        if (result["GetEmployeePolicyType"] == null) {
          print("GetEmployeePolicyType is null");
          return [];
        }

        final list = result["GetEmployeePolicyType"] as List;
        print("list length: ${list.length}");

        if (list.isEmpty) {
          print("No policy types found for employee $employeeId");
          return [];
        }

        return list
            .where((e) => e["PolicyName"] != null)
            .map((e) => e["PolicyName"].toString())
            .toList();
      } else {
        print("Error fetching policy types: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception fetching policy types: $e");
      return [];
    }
  }

  Future<void> loadPolicyNumbers(String policyType) async {
    if (policyType.isEmpty) return;

    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }

    try {
      setState(() => isPolicyNumberLoading = true);

      final employeeId =
          controllers.authUserProfileData['employeeID']?.toString() ??
          controllers.authUserProfileData['employeeId']?.toString() ??
          "";

      final body = {"EmployeeID": employeeId, "PolicyName": policyType};

      print(
        "Fetching policy numbers for: $policyType, EmployeeID: $employeeId",
      );

      final response = await ApiService.postRequest(
        url: "$baseUrl/api/Account/GetEmployeePolicyNumber",
        body: body,
        token: token,
      );

      if (response != null &&
          response['Result']?['GetEmployeePolicyNumber'] != null) {
        final list = response['Result']['GetEmployeePolicyNumber'] as List;

        print("Policy numbers received: $list");

        setState(() {
          policyNumberList = list
              .where(
                (item) =>
                    item['PolicyNo'] != null && item['PolicyInputID'] != null,
              )
              .map(
                (item) => {
                  'PolicyNo': item['PolicyNo'].toString(),
                  'PolicyInputID': item['PolicyInputID'].toString(),
                },
              )
              .toList();

          // Clear dependent data when policy number changes
          dependentList = [];
          selectedPolicyInputId = "";
          selectedPolicyNumber = "";
          selectedRelation = "";
          selectedPatientName = "";
          selectedGender = "";
          ageController.clear();
        });
      } else {
        print("No policy numbers found or invalid response");
        setState(() {
          policyNumberList = [];
          selectedPolicyNumber = "";
          selectedPolicyInputId = "";
          dependentList = [];
          selectedRelation = "";
          selectedPatientName = "";
          selectedGender = "";
          ageController.clear();
        });
      }
    } catch (e) {
      print("Error fetching policy numbers: $e");
      setState(() {
        policyNumberList = [];
        selectedPolicyNumber = "";
        selectedPolicyInputId = "";
        dependentList = [];
        selectedRelation = "";
        selectedPatientName = "";
        selectedGender = "";
        ageController.clear();
      });
    } finally {
      if (mounted) {
        setState(() => isPolicyNumberLoading = false);
      }
    }
  }

  Future<void> loadDependentDetails() async {
    if (selectedPolicyInputId.isEmpty) return;

    final token = controllers.authToken.toString();
    if (token == null || token.toString().trim().isEmpty) {
      print("Token missing → Redirecting to Login");
      controllers.authUser.clear();
      Get.offAll(() => LoginSelection());
      return;
    }

    try {
      setState(() => isDependentLoading = true);

      final employeeId =
          controllers.authUserProfileData['employeeID']?.toString() ??
          controllers.authUserProfileData['employeeId']?.toString() ??
          "";

      final body = {
        "EmployeeID": int.parse(employeeId),
        "Gender": "All",
        "PolicyInputId": int.parse(selectedPolicyInputId),
      };

      print("Fetching dependent details with body: $body");

      final response = await ApiService.postRequest(
        url: "$baseUrl/api/Account/GetEmployeePolicyNumberDetailsbyDependent",
        body: body,
        token: token,
      );

      if (response != null &&
          response['Result']?['GetEmployeePolicyNumberbyDependent'] != null) {
        final list =
            response['Result']['GetEmployeePolicyNumberbyDependent'] as List;

        print("Dependent details received: $list");

        setState(() {
          dependentList = list
              .where((item) => item['DependentName'] != null)
              .map(
                (item) => {
                  'PolicyInputID': item['PolicyInputID'].toString(),
                  'RelationName': item['RelationName']?.toString() ?? "",
                  'DependentName': item['DependentName'].toString().trim(),
                  'EmployeeID': item['EmployeeID'].toString(),
                  'EmployeeDependentID':
                      item['EmployeeDependentID']?.toString() ?? "",
                },
              )
              .toList();

          // Auto-select the first dependent if available
          if (dependentList.isNotEmpty) {
            final firstDependent = dependentList.first;
            selectedRelation = firstDependent['RelationName'] ?? "";
            selectedPatientName = firstDependent['DependentName'] ?? "";
          }
        });
      } else {
        print("No dependent details found or invalid response");
        setState(() {
          dependentList = [];
          selectedRelation = "";
          selectedPatientName = "";
          selectedGender = "";
          ageController.clear();
        });
      }
    } catch (e) {
      print("Error fetching dependent details: $e");
      setState(() {
        dependentList = [];
        selectedRelation = "";
        selectedPatientName = "";
        selectedGender = "";
        ageController.clear();
      });
    } finally {
      if (mounted) {
        setState(() => isDependentLoading = false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoFillFormData();
      loadPolicyTypes();
    });
  }

  void _autoFillFormData() {
    if (controllers.authUserProfileData.isNotEmpty) {
      setState(() {
        employeeCodeController.text =
            controllers.authUserProfileData['employeeCode']?.toString() ?? '';

        String firstName =
            controllers.authUserProfileData['firstName']?.toString() ?? '';
        String lastName =
            controllers.authUserProfileData['lastName']?.toString() ?? '';
        employeeNameController.text = '$firstName $lastName'.trim();

        emailIDController.text =
            controllers.authUserProfileData['emailAddress']?.toString() ?? '';

        mobileNoController.text =
            controllers.authUserProfileData['mobileNo']?.toString() ?? '';
      });
    }
  }

  @override
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

              // Policy Type Dropdown
              isPolicyTypeLoading
                  ? Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircularProgressIndicator(strokeWidth: 2),
                          SizedBox(width: 10),
                          Text(
                            "Loading policy types...",
                            style: AppTextTheme.paragraph,
                          ),
                        ],
                      ),
                    )
                  : CustomDropdownOverlay(
                      label: "Policy Type",
                      options: policyTypeList,
                      selectedValue: selectedPolicyType,
                      onSelected: (value) {
                        setState(() {
                          selectedPolicyType = value;
                          // Clear previous selections
                          policyNumberList = [];
                          selectedPolicyNumber = "";
                          selectedPolicyInputId = "";
                          dependentList = [];
                          selectedRelation = "";
                          selectedPatientName = "";
                          selectedGender = "";
                          ageController.clear();

                          // Load policy numbers for selected type
                          if (value.isNotEmpty) {
                            loadPolicyNumbers(value);
                          }
                        });
                      },
                    ),
              SizedBox(height: 5),

              // Policy Number Dropdown
              isPolicyNumberLoading
                  ? Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircularProgressIndicator(strokeWidth: 2),
                          SizedBox(width: 10),
                          Text(
                            "Loading policy numbers...",
                            style: AppTextTheme.paragraph,
                          ),
                        ],
                      ),
                    )
                  : CustomDropdownOverlay(
                      label: "Policy No",
                      options: getPolicyNumberOptions(), // Use helper method
                      selectedValue: selectedPolicyNumber,
                      onSelected: (value) {
                        setState(() {
                          selectedPolicyNumber = value;

                          // Find and store the PolicyInputID for the selected policy number
                          final selectedItem = policyNumberList.firstWhere(
                            (item) => item['PolicyNo'] == value,
                            orElse: () => {},
                          );

                          selectedPolicyInputId =
                              selectedItem['PolicyInputID'] ?? "";

                          // Clear dependent data
                          dependentList = [];
                          selectedRelation = "";
                          selectedPatientName = "";
                          selectedGender = "";
                          ageController.clear();

                          // Load dependent details
                          if (selectedPolicyInputId.isNotEmpty) {
                            loadDependentDetails();
                          }
                        });
                      },
                    ),
              SizedBox(height: 5),

              // Relation Dropdown
              isDependentLoading
                  ? Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          CircularProgressIndicator(strokeWidth: 2),
                          SizedBox(width: 10),
                          Text(
                            "Loading dependents...",
                            style: AppTextTheme.paragraph,
                          ),
                        ],
                      ),
                    )
                  : CustomDropdownOverlay(
                      label: "Relation",
                      options: getRelationOptions(), // Use helper method
                      selectedValue: selectedRelation,
                      onSelected: (value) {
                        setState(() {
                          selectedRelation = value;

                          // Find the corresponding dependent for the selected relation
                          final selectedDependent = dependentList.firstWhere(
                            (item) => item['RelationName'] == value,
                            orElse: () => {},
                          );

                          selectedPatientName =
                              selectedDependent['DependentName'] ?? "";

                          // You can add logic here to fetch age and gender based on the selected dependent
                          // For now, we'll set empty values
                          selectedGender = "";
                          ageController.clear();
                        });
                      },
                    ),
              SizedBox(height: 5),

              // Patient Name Dropdown
              CustomDropdownOverlay(
                label: "Patient or Member Name",
                options: getPatientNameOptions(), // Use helper method
                selectedValue: selectedPatientName,
                onSelected: (value) {
                  setState(() {
                    selectedPatientName = value;

                    // Find the corresponding relation for the selected patient
                    final selectedDependent = dependentList.firstWhere(
                      (item) => item['DependentName'] == value,
                      orElse: () => {},
                    );

                    selectedRelation = selectedDependent['RelationName'] ?? "";

                    // You can add logic here to fetch age and gender based on the selected patient
                    selectedGender = "";
                    ageController.clear();
                  });
                },
              ),
              SizedBox(height: 5),

              // Age TextField
              CustomTextFieldWithName(
                keyboardType: TextInputType.number,
                controller: ageController,
                onChanged: (value) {
                  // No need to setState here as controller handles it
                },
                hintText: "Enter Age",
                ddName: 'Age',
              ),
              SizedBox(height: 5),

              // Gender Dropdown
              CustomDropdownOverlay(
                label: "Gender",
                options: ["Male", "Female", "Other"],
                selectedValue: selectedGender,
                onSelected: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
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
