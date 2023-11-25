import 'package:baitap08/repository/user_login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  String userPhone = "";

  Future<void> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    userPhone = prefs.getString('phone') ?? "";
    notifyListeners();
  }

  void updatePhone(String phone) {
    userPhone = phone;
    notifyListeners();
  }

  Future<bool?> login(String phone, String password) async {
    try {
      var response = await UserLoginRepo().logIn(phone);
      if (password == response.password) {
        await savePhoneAndToken(phone);
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
    await prefs.setString('phone', phone);
    UserLoginRepo().saveToken(phone);
  }

  Future<bool> tokenExpired() async {
    await getPhone();
    if (userPhone == "") {
      return true;
    }
    try {
      var response = await UserLoginRepo().logIn(userPhone);

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
    FirebaseAuth.instance.signOut();
    updatePhone("");
  }
}
