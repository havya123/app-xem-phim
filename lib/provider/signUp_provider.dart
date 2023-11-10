import 'package:baitap08/repository/user_signup_repo.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  void signUp(String phone, String password, String name, String email,
      String address) {
    SignUpRepo().signUp(phone, password, name, email, address);
  }

  Future<bool> isRegistered(String phone) {
    return SignUpRepo().isRegistered(phone);
  }
}
