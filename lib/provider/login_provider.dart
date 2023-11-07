import 'package:baitap08/repository/user_login_repo.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  Future<bool?> login(String phone, String password) async {
    try {
      var response = await UserLoginRepo().logIn("84${phone.substring(1)}");
      if (password == response.password) {
        return true;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
