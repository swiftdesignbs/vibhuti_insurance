import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vibhuti_insurance_mobile_app/screens/book_slot_dental_checkup.dart';
import 'package:vibhuti_insurance_mobile_app/screens/book_slot_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/base_scaffold.dart';
import 'package:vibhuti_insurance_mobile_app/screens/my_policy_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/notification_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/profile_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/settings.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_textfield.dart';

// Dummy Screens (same as before)
class DentalCheckUpScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const DentalCheckUpScreen({super.key, this.scaffoldKey});

  @override
  State<DentalCheckUpScreen> createState() => _DentalCheckUpScreenState();
}

class _DentalCheckUpScreenState extends State<DentalCheckUpScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedValue = 'Option 1';
  String selectedGender = 'All';

  final List<Map<String, dynamic>> _allHospitals = [
    {
      "id": '1',
      "name": '32 Smiles Dental Clinic',
      "address":
          'Shop No. 12, Green Park Building, Lokhandwala Complex, Andheri West, Mumbai - 400053, Maharashtra, India. Near Versova Metro Station.',
      "latitude": 19.1360,
      "longitude": 72.8279,
      "area": 'Andheri West',
      "phone": '+91-22-2634-1234',
      "type": 'Dental Clinic',
    },
    {
      "id": '2',
      "name": 'Dr. D\'Costa Dental Care',
      "address":
          'Shop No. 5, Gloria Church Road, Bandra West, Mumbai - 400050, Maharashtra, India. Near Bandra Talkies and Hill Road.',
      "latitude": 19.0567,
      "longitude": 72.8290,
      "area": 'Bandra West',
      "phone": '+91-22-2642-8899',
      "type": 'Dental Clinic',
    },
    {
      "id": '3',
      "name": 'Smilekraft Dental Clinic',
      "address":
          'Ground Floor, Ameya House, Bhulabhai Desai Road, Breach Candy, Mumbai - 400026, Maharashtra, India. Opposite Breach Candy Club.',
      "latitude": 18.9658,
      "longitude": 72.8080,
      "area": 'Cumballa Hill',
      "phone": '+91-22-2369-5555',
      "type": 'Dental Clinic',
    },
    {
      "id": '4',
      "name": 'The Dental Studio',
      "address":
          'Shop No. 8, Pearl Center, Marine Lines, Mumbai - 400020, Maharashtra, India. Near Churchgate Station and Marine Drive.',
      "latitude": 18.9445,
      "longitude": 72.8262,
      "area": 'Marine Lines',
      "phone": '+91-22-2287-2222',
      "type": 'Dental Clinic',
    },
    {
      "id": '5',
      "name": 'Bright Smiles Dental Care',
      "address":
          'G-2, Crystal Plaza, Dr. G. Deshmukh Marg, Pedder Road, Mumbai - 400026, Maharashtra, India. Near Jaslok Hospital.',
      "latitude": 18.9595,
      "longitude": 72.8091,
      "area": 'Pedder Road',
      "phone": '+91-22-6658-1111',
      "type": 'Dental Clinic',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Dental CheckUp", style: AppTextTheme.pageTitle),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
          icon: Image.asset('assets/icons/menu.png', height: 24, width: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // --- Option 1 ---
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() => selectedValue = 'Option 1');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: 'Option 1',
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() => selectedValue = value!);
                          },
                        ),
                        const Text('My Location', style: AppTextTheme.subTitle),
                      ],
                    ),
                  ),
                ),

                // --- Option 2 ---
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() => selectedValue = 'Option 2');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Radio<String>(
                          value: 'Option 2',
                          groupValue: selectedValue,
                          onChanged: (value) {
                            setState(() => selectedValue = value!);
                          },
                        ),
                        const Text('Manually', style: AppTextTheme.subTitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppTextTheme.primaryColor),
                borderRadius: BorderRadius.circular(8),
              ),
              height: 200,

              child: Center(
                child: Text("Map Placeholder", style: AppTextTheme.subTitle),
              ),
            ),
            SizedBox(height: 10),
            Text('Diagnosis Centre List', style: AppTextTheme.subTitle),
            SizedBox(height: 10),
            CustomTextField(
              controller: searchController,
              hintText: "Search Hostpital Name",
              suffixIcon: FaIcon(
                FontAwesomeIcons.magnifyingGlass,
                color: AppTextTheme.primaryColor,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // --- All ---
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => selectedGender = 'All'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: 'All',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() => selectedGender = value!);
                          },
                        ),
                        const Text('All', style: AppTextTheme.subTitle),
                      ],
                    ),
                  ),
                ),

                // --- Male ---
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => selectedGender = 'Male'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: 'Male',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() => selectedGender = value!);
                          },
                        ),
                        const Text('Male', style: AppTextTheme.subTitle),
                      ],
                    ),
                  ),
                ),

                // --- Female ---
                Expanded(
                  child: InkWell(
                    onTap: () => setState(() => selectedGender = 'Female'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: 'Female',
                          groupValue: selectedGender,
                          onChanged: (value) {
                            setState(() => selectedGender = value!);
                          },
                        ),
                        const Text('Female', style: AppTextTheme.subTitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            Text('Hospital Center / Count : 10', style: AppTextTheme.subTitle),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _allHospitals.length,
                itemBuilder: (context, index) {
                  final hospital = _allHospitals[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    //  padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppTextTheme.primaryColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    hospital['name'],
                                    style: AppTextTheme.subTitle,
                                  ),
                                  Image.asset(
                                    "assets/icons/fav_icon.png",
                                    height: 24,
                                    width: 24,
                                  ),
                                ],
                              ),
                              Text(
                                hospital['address'],
                                style: AppTextTheme.paragraph,
                              ),
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    BookSlotDentalCheckUpScreen(),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppTextTheme.primaryColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),

                            child: Center(
                              child: Text(
                                'Book Slot',
                                style: AppTextTheme.buttonText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
