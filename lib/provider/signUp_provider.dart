import 'package:baitap08/repository/user_signup_repo.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  Future<void> signUp(String password) async {
    await SignUpRepo().signUp(password);
  }
}
