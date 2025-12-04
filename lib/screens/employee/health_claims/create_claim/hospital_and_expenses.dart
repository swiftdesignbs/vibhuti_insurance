import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/health_claims/create_claim/bank_details.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/custom_input_with_name.dart';
import 'package:vibhuti_insurance_mobile_app/widgets/regular_btn.dart';

class HospitalAndExpensesScreen extends StatefulWidget {
  const HospitalAndExpensesScreen({super.key});

  @override
  State<HospitalAndExpensesScreen> createState() =>
      _HospitalAndExpensesScreenState();
}

class _HospitalAndExpensesScreenState extends State<HospitalAndExpensesScreen> {
  TextEditingController hospitalName = TextEditingController();
  TextEditingController employeeCode = TextEditingController();
  TextEditingController dischargeDate = TextEditingController();
  TextEditingController admissionDate = TextEditingController();

  Future<String?> _showCalenderBottomSheet(BuildContext context) async {
    return showModalBottomSheet(useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final sheetHeight = screenHeight > 700 ? 0.7 : 0.90;

        int selectedYear = DateTime.now().year;
        int selectedTab = 0; // 0 = Calendar, 1 = Filter

        List<int> years = List.generate(25, (i) => DateTime.now().year - i);

        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(color: Colors.black.withOpacity(0.1)),
                ),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: FractionallySizedBox(
                    heightFactor: sheetHeight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          child: Column(
                            children: [
                              Center(
                                child: Container(
                                  height: 5,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0xff004370),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),

                              /// ------------------ TAB BUTTONS -------------------
                              Row(
                                children: [
                                  Expanded(
                                    child: FilterButtons(
                                      onPressed: () {
                                        setState(() => selectedTab = 0);
                                      },
                                      ddName: "Calendar",
                                      width: double.infinity,
                                      isActive: selectedTab == 0,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: FilterButtons(
                                      onPressed: () {
                                        setState(() => selectedTab = 1);
                                      },
                                      ddName: "Filter",
                                      width: double.infinity,
                                      isActive: selectedTab == 1,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 20),

                              Expanded(
                                child: selectedTab == 0
                                    ? _calendarView(context, (value) {
                                        Navigator.pop(
                                          context,
                                          value,
                                        ); // Pop correctly
                                      })
                                    : _filterView(years, selectedYear, (year) {
                                        setState(() => selectedYear = year);
                                      }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                  Text(
                    'Hospital & Expense Details',
                    style: AppTextTheme.subTitle,
                  ),
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
      ),   backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hospital & Expense Details', style: AppTextTheme.subTitle),
            CustomTextFieldWithName(
              controller: hospitalName,
              ddName: 'Hospital Name',
              suffixIcon: "assets/icons/down_icon.svg",
            ),
            SizedBox(height: 5),

            CustomTextFieldWithName(
              controller: admissionDate,
              ddName: 'Admission Date',
              suffixIcon: "assets/icons/calender.svg",
              onTap: () async {
                final selectedDate = await _showCalenderBottomSheet(context);
                if (selectedDate != null) {
                  admissionDate.text = selectedDate;
                }
              },

              readOnly: true,
            ),

            SizedBox(height: 5),

            CustomTextFieldWithName(
              controller: dischargeDate,
              ddName: 'Discharge Date',
              suffixIcon: "assets/icons/calender.svg",
              onTap: () async {
                final selectedDate = await _showCalenderBottomSheet(context);
                if (selectedDate != null) {
                  dischargeDate.text = selectedDate;
                }
              },
              readOnly: true,
            ),

            SizedBox(height: 5),

            CustomTextFieldWithName(
              controller: employeeCode,
              ddName: 'Discharge Date',
            ),
            SizedBox(height: 5),
            CustomTextFieldWithName(
              controller: employeeCode,
              ddName: 'Discharge Date',
            ),
            Spacer(),
            Buttons(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BankDetailsScreen()),
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

Widget _calendarView(BuildContext context, Function(String) onSelectDate) {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  return StatefulBuilder(
    builder: (context, setState) {
      return TableCalendar(
        focusedDay: _focusedDay,
        firstDay: DateTime(1900),
        lastDay: DateTime(2900),

        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

        calendarStyle: CalendarStyle(
          todayDecoration: const BoxDecoration(
            color: AppTextTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          todayTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          selectedDecoration: const BoxDecoration(
            color: AppTextTheme.primaryColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0XFF00635F),
                offset: Offset(3, 3),
                blurRadius: 0,
              ),
            ],
          ),
          selectedTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });

          final formattedDate =
              "${selectedDay.day.toString().padLeft(2, '0')}/"
              "${selectedDay.month.toString().padLeft(2, '0')}/"
              "${selectedDay.year}";

          onSelectDate(formattedDate); // 🔥 Return selected date
        },
      );
    },
  );
}

/// FILTER TAB — YEAR LIST WITH RADIO BUTTONS
Widget _filterView(
  List<int> years,
  int selectedYear,
  Function(int) onYearSelect,
) {
  return ListView.builder(
    itemCount: years.length,
    itemBuilder: (context, index) {
      return RadioListTile<int>(
        value: years[index],
        groupValue: selectedYear,
        title: Text(
          years[index].toString(),
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        onChanged: (value) {
          onYearSelect(value!);
        },
      );
    },
  );
}
