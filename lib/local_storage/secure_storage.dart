import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage secureStorage = FlutterSecureStorage();

Future<void> clear() async {
  await secureStorage.deleteAll();
}

Future<void> save(String key, String value) async {
  await secureStorage.write(key: key, value: value);
}

Future<String> getValue(String key) async {
  return await secureStorage.read(key: key) ?? "";
}

Future saveAuthToken(token) async {
  return await save('AUTH_TOKEN', token);
}

Future saveAuthUser(data) async {
  return await save('AUTH_USER', jsonEncode(data));
}

Future saveFirebaseToken(data) async {
  print("hello FirebaseToken is $data");
  return await save('FIREBASE_TOKEN', data);
}

Future getAuthToken() async {
  return await getValue('AUTH_TOKEN');
}

Future getAuthUser() async {
  var user = await getValue('AUTH_USER');
  if (user != '') {
    return jsonDecode(user);
  } else {
    var userNew = {};
    await saveAuthUser(userNew);
    return userNew;
  }
}

Future getFirebaseToken() async {
  return await getValue('FIREBASE_TOKEN');
}

Future deleteAuthUser() async {
  await secureStorage.delete(key: 'AUTH_USER');
}

Future deleteAuthToken() async {
  await secureStorage.delete(key: 'AUTH_TOKEN');
}

Future deleteFirebaseToken() async {
  await secureStorage.delete(key: 'FIREBASE_TOKEN');
}
