import 'package:shared_preferences/shared_preferences.dart';

const String KEY_USER_AUTH_TOKEN = "USER_AUTH";
const String KEY_USER_NAME = "USER_NAME";
const String KEY_USER_EMAIL = "USER_EMAIL";
const String KEY_USER_AVATAR = "USER_AVA";

const String KEY_USER_BALANCE = "USER_BALANCE";

const String KEY_IS_LOGGEDIN = "IS_LOGIN";

class SharedPrefManager {
  Future<String> addStringToSF(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    return "success";
  }

  Future<int> addIntToSF(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
    return 1;
  }

  Future<double> addDoubleToSF(String key, double value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
    return 1;
  }

  Future<bool> addBoolToSF(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
    return true;
  }

  // READ VALUE
  Future<String?> getStringValueSF(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<bool?> getBoolValueSF(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future<int?> getIntValueSF(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  Future<double?> getDoubleValueSF(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  // CLEAR PREF
  clearSF() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
