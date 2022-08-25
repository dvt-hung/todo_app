import 'dart:convert';

import 'package:noteapp/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  static final Preferences preferences = Preferences();

  Future<String> get(String key) async {
    final SharedPreferences prefs = await _prefs;
    return json.decode(prefs.getString(key)!) ?? '';
  }

  Future<String> getObject(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences prefs = await _prefs;
    final isRemember = prefs.getBool(key) ?? false;
    print(isRemember.runtimeType);
    return isRemember;
    // return prefs.getBool(key) ?? false;
  }

  Future set(String key, dynamic value) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(key, json.encode(value));
  }

  Future remove(String key) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove(key);
  }

  Future clear() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }

  void setUserPreference(UserModel user) {
    final Map<String, dynamic> userString = user.toJson();
    preferences.set("user", userString);
  }

  Future<UserModel?> getUserPreference() async {
    final String? userString = await preferences.getObject("user");
    if (userString != null && userString.isNotEmpty) {
      final Map<String, dynamic> map =
          jsonDecode(userString) as Map<String, dynamic>;
      return UserModel.fromJson(map);
    } else {
      return null;
    }
  }
}
