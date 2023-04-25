import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetails {
  String? email;
  String? password;

  UserDetails({ this.email, this.password });
}

class Preferences {

  static Future<void> saveUserDetails(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("email", email);
    await prefs.setString("password", password);
    log("User details saved!");
  }

  static Future<UserDetails> fetchUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString("email");
    String? password = prefs.getString("password");

    return UserDetails(
      email: email,
      password: password
    );
  }

  static Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    log("Preferences cleared!");
  }
  

}