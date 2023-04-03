import 'dart:convert';

import 'package:insurance_mobile_app/shared/models/application_user/application_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final String _tokenPrefix = 'Bearer';

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<String?> get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static void setString(String key, String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, data);
  }

  static void remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<ApplicationUser> getCurrentUser() async {
    String? user = await Preferences.get('currentUser');
    dynamic json = jsonDecode(user!);
    return ApplicationUser.fromJson(json);
  }

}