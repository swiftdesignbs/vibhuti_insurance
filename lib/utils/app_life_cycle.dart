import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vibhuti_insurance_mobile_app/local_storage/secure_storage.dart';
import 'package:vibhuti_insurance_mobile_app/screens/login/login_selection.dart';
import 'package:vibhuti_insurance_mobile_app/state_management/state_management.dart';

class AppLifecycleService with WidgetsBindingObserver {
  DateTime? backgroundTime;

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void disposeService() {
    WidgetsBinding.instance.removeObserver(this);
  }

  final dataController = Get.put(StateController());

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      // App goes to background
      backgroundTime = DateTime.now();
      await save("APP_BACKGROUND_TIME", backgroundTime.toString());
      print("➡️ App moved to background at $backgroundTime");
    }

    if (state == AppLifecycleState.resumed) {
      final stored = await getValue("APP_BACKGROUND_TIME");
      if (stored.isNotEmpty) {
        final diff = DateTime.now()
            .difference(DateTime.parse(stored))
            .inMinutes;

        if (diff >= 5) {
          await logout();
        }
      }
    }
  }

  Future<void> logout() async {
    try {
      await dataController.unsetAuth();
    } catch (err) {
      print("Eror during logout: $err");
    }

    Get.offAll(() => const LoginSelection());
  }
}
