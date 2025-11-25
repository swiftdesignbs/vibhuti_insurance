import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/screens/booking_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/dashboard_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/main_screen.dart';
import 'package:vibhuti_insurance_mobile_app/screens/splash_screen.dart';
import 'package:vibhuti_insurance_mobile_app/utils/app_text_theme.dart';
import 'package:device_preview_plus/device_preview_plus.dart';

void main() {
  runApp(MyApp());
}
// void main() => runApp(
//   DevicePreview(
//     builder: (context) => MyApp(), // Wrap your app
//   ),
// );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // ignore: deprecated_member_use
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
