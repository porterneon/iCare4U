import 'dart:convert';

import 'package:icare4u_ui/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  final String userDetailsKey = 'userDetails';

  Future saveUserDetails(UserDetails userDetails) async {
    var prefs = await SharedPreferences.getInstance();
    var data = jsonEncode(userDetails);

    await prefs.setString(userDetailsKey, data);
  }

  Future<UserDetails> getUserDetails() async {
    var prefs = await SharedPreferences.getInstance();
    var value = prefs.get(userDetailsKey);

    if (value == null) return null;

    return UserDetails.fromJson(jsonDecode(value));
  }

  Future deleteUserDetails() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(userDetailsKey);
  }
}
