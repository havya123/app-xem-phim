import 'package:baitap08/model/user.dart';
import 'package:baitap08/model/user_review.dart';
import 'package:baitap08/repository/film_review_repo.dart';
import 'package:baitap08/repository/user_detail_repo.dart';
import 'package:flutter/material.dart';

class FilmReviewProvider extends ChangeNotifier {
  List<UserReview> listReview = [];
  List<UserModel> listUser = [];
  Future<void> createListReview(String movieID) async {
    await FilmReviewRepo().createListReviews(movieID);
  }

  Future<void> getListReview(String movieID) async {
    listReview = await FilmReviewRepo().getListReview(movieID);
    if (listReview != []) {
      List<String> listID = listReview.map((e) => e.userID).toList();
      listUser = await UserDetailRepo().getListUser(listID);
    }
    notifyListeners();
  }
}
