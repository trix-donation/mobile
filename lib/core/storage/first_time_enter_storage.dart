import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeEnterStorage {
  static const String _firstTimeEnterKey = 'firstTimeEnter';

  FistTimeEnterStorage() async {
    await checkFirstTimeEnter();
  }

  static bool isFirstTimeEnter = true;

  static Future<void> setFirstTimeEnter(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeEnterKey, value);
    isFirstTimeEnter = value;
  }

  static Future<void> checkFirstTimeEnter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTimeEnter = prefs.getBool(_firstTimeEnterKey) ?? true;
  }
}
