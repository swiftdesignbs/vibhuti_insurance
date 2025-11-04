import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
class NotificationScreen extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const NotificationScreen({super.key, this.scaffoldKey});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedValue = 'Option 1';
  String selectedGender = 'All';

  final List<Map<String, dynamic>> _allHospitals = [
    {
      "id": '1',
      "name": 'Kokilaben Dhirubhai Ambani Hospital',
      "address":
          'Rao Saheb Achutrao Patwardhan Marg, Four Bungalows, Andheri West, Mumbai - 400053, Maharashtra, India. Near DN Nagar Metro Station.',
      "latitude": 19.1324,
      "longitude": 72.8273,
      "area": 'Andheri West',
      "phone": '+91-22-3099-9999',
      "type": 'Multi-Specialty',
    },
    {
      "id": '2',
      "name": 'Lilavati Hospital and Research Centre',
      "address":
          'A-791, Bandra Reclamation, Bandra West, Mumbai - 400050, Maharashtra, India. Opposite MIG Cricket Club, easily accessible from Western Express Highway.',
      "latitude": 19.0590,
      "longitude": 72.8229,
      "area": 'Bandra West',
      "phone": '+91-22-2675-1000',
      "type": 'Multi-Specialty',
    },
    {
      "id": '3',
      "name": 'Breach Candy Hospital',
      "address":
          '60 A, Bhulabhai Desai Road, Breach Candy, Cumballa Hill, Mumbai - 400026, Maharashtra, India. Located near Mahalaxmi Temple and Haji Ali Junction.',
      "latitude": 18.9661,
      "longitude": 72.8063,
      "area": 'Cumballa Hill',
      "phone": '+91-22-2367-2888',
      "type": 'Multi-Specialty',
    },
    {
      "id": '4',
      "name": 'Bombay Hospital',
      "address":
          '12, New Marine Lines, Churchgate, Mumbai - 400020, Maharashtra, India. Close to Marine Drive and CST Station, landmark: Liberty Cinema.',
      "latitude": 18.9439,
      "longitude": 72.8259,
      "area": 'Marine Lines',
      "phone": '+91-22-2206-7676',
      "type": 'Multi-Specialty',
    },
    {
      "id": '5',
      "name": 'Jaslok Hospital and Research Centre',
      "address":
          '15, Dr. G. Deshmukh Marg, Pedder Road, Mumbai - 400026, Maharashtra, India. Near Sophia College and Haji Ali Circle, easily accessible via Worli route.',
      "latitude": 18.9597,
      "longitude": 72.8082,
      "area": 'Pedder Road',
      "phone": '+91-22-6657-3333',
      "type": 'Multi-Specialty',
    },
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTextTheme.appBarColor,
        title: Text("Health CheckUp", style: AppTextTheme.pageTitle),
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
                        const Text(
                          'Use My Location',
                          style: AppTextTheme.subTitle,
                        ),
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
                        const Text(
                          'Choose Manually',
                          style: AppTextTheme.subTitle,
                        ),
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
                                builder: (context) => BookSlotHealthCheckUpScreen(),
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
