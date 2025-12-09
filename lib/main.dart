import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vibhuti_insurance_mobile_app/local_storage/secure_storage.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/employee_booking_module/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/employee/dashboard/main_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/splash_screen.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_life_cycle.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:device_preview_plus/device_preview_plus.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Initialize lifecycle
//   final appLifecycleService = AppLifecycleService();
//   appLifecycleService.init();

//   /// REQUEST PERMISSIONS HERE
//   await _askPermissions();
//   await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

//   final controller = Get.put(StateController());
//   await controller.initAuth();

//   // ---- FORCE AUTO LOGOUT ON APP RESTART ----
//   final token = await getAuthToken();
//   if (token != null && token.toString().isNotEmpty) {
//     // user had active session before app kill — force logout
//     await controller.unsetAuth();
//   }
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize lifecycle
  final appLifecycleService = AppLifecycleService();
  appLifecycleService.init();

  /// REQUEST PERMISSIONS HERE
  await _askPermissions();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);

  final controller = Get.put(StateController());
  await controller.initAuth();

  // ---- FORCE AUTO LOGOUT ON APP RESTART ----
  final token = await getAuthToken();
  if (token != null && token.toString().isNotEmpty) {
    // user had active session before app kill — force logout
    await controller.unsetAuth();
  }

  runApp(DevicePreview(builder: (context) => MyApp()));
}

Future<void> _askPermissions() async {
  if (await Permission.storage.isDenied) {
    await Permission.storage.request();
  }

  if (await Permission.manageExternalStorage.isDenied) {
    await Permission.manageExternalStorage.request();
  }

  if (await Permission.location.isDenied) {
    await Permission.location.request();
  }

  /// NOTIFICATION permission (Downloader needs it on Android 13)
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Vibhuti Insurance',
      theme: ThemeData(
        // Primary Color
        primaryColor: const Color(0xFF00B3AC),

        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00B3AC),
          primary: const Color(0xFF00B3AC),
        ),

        // App Bar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00B3AC),
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        // Floating Action Button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF00B3AC),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00B3AC),
            foregroundColor: Colors.white,
            textStyle: AppTextTheme.buttonText,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFF00B3AC),
          selectionColor: Color(0x3300B3AC),
          selectionHandleColor: Color(0xFF00B3AC),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00B3AC)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusColor: const Color(0xFF00B3AC),
          labelStyle: const TextStyle(color: Color(0xFF00B3AC)),
        ),

        // Font Family & Text Theme
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headlineSmall: AppTextTheme.pageTitle,
          titleMedium: AppTextTheme.subTitle,
          bodyMedium: AppTextTheme.paragraph,
          labelLarge: AppTextTheme.buttonText,
        ),
      ),
      home: SplashScreen(),
    );
  }
}
