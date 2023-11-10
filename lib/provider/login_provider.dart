import 'package:baitap08/repository/user_login_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  Future<bool?> login(String phone, String password) async {
    try {
      var response = await UserLoginRepo().logIn(phone);
      if (password == response.password) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> savePhoneAndToken(String phone) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("phone", phone);
    UserLoginRepo().saveToken(phone);
  }

  Future<bool> tokenExpired() async {
    final prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phone") ?? "";
    if (phone == "") {
      return true;
    }
    try {
      var response = await UserLoginRepo().logIn(phone);

      var now = DateTime.now();
      if (response.token == "") {
        return true;
      }
      if (now.compareTo(DateTime.parse(response.token as String)) > 0) {
        return true;
      }
      return false;
    } catch (e) {
      return true;
    }
  }

  Future<void> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
