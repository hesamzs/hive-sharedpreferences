import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCore {
  static String SaveInt = "SaveInt";
  static String SaveBool = "SaveBool";
  static String SaveString = "SaveString";

  Future<bool> saveToInt(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setInt(SaveInt, value);
  }

  static Future getInt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(SaveInt);
  }

  Future<bool> saveToBool(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(SaveBool, value);
  }

  static Future getBool() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(SaveBool);
  }

  Future<bool> saveToString(value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(SaveString, value);
  }

  static Future getString() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(SaveString);
  }
}
