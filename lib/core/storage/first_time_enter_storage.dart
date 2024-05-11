import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeEnterStorage {
  static const String _firstTimeEnterKey = 'firstTimeEnter';

  bool? isFirstTimeEnter;

  Future<void> setFirstTimeEnter(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_firstTimeEnterKey, value);
    isFirstTimeEnter = value;
  }

  Future<void> checkFirstTimeEnter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstTimeEnter = prefs.getBool(_firstTimeEnterKey);
  }
}
