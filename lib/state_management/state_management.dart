import 'dart:convert';
import 'dart:developer';

import 'package:get/state_manager.dart';
import 'package:vibhuti_insurance_mobile_app/local_storage/secure_storage.dart';

class StateController extends GetxController {
  final authToken = ''.obs;
  final authUser = {}.obs;
  final authUserProfileData = {}.obs;
  final authFirebaseToken = ''.obs;

  initAuth() async {
    final authTokenVal = await getAuthToken();
    final authUserVal = await getAuthUser();
    final authUserProfileVal = await getAuthUserProfileData();
    final authFirebaseTokenVal = await getFirebaseToken();
    authToken.value = authTokenVal;
    authUser.value = authUserVal;
    authFirebaseToken.value = authFirebaseTokenVal;
  }

  setAuthToken(data) async {
    log('setAuthToken');
    log(jsonEncode(data));
    authToken.value = data;
    await saveAuthToken(data);
  }

  setAuthUser(data) async {
    log('setAuthUser');
    log(jsonEncode(data));
    authUser.value = data;
    await saveAuthUser(data);
  }

  setAuthUserProfileData(data) async {
    log('setAuthUserProfileData');
    log(jsonEncode(data));
    authUserProfileData.value = data;
    await saveAuthUserProfileData(data);
  }

  setFirebaseToken(data) async {
    log('setFirebaseToken');
    log(jsonEncode(data));
    authFirebaseToken.value = data;
    await saveFirebaseToken(data);
  }

  unsetAuth() async {
    authToken.value = '';
    authUser.value = {};
    authUserProfileData.value = {};
    await deleteAuthUser();
    await deleteAuthToken();
    await deleteAuthUserProfileData();
  }
}
