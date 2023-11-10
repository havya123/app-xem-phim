import 'package:baitap08/repository/user_review_repo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserReviewProvider extends ChangeNotifier {
  Future<void> postReview(String movieID, String review, String rating) async {
    final prefs = await SharedPreferences.getInstance();
    String phone = prefs.getString("phone") as String;
    await UserReviewRepo().postReview(movieID, phone, review, rating);
  }
}
