import 'package:baitap08/repository/user_login_repo.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  void login(String phone, String password, VoidCallback onSuccess,
      VoidCallback error) async {
    await UserLoginRepo().logIn(phone, password, onSuccess, error);
  }
}
