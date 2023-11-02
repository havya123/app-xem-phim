import 'package:baitap08/model/review.dart';
import 'package:baitap08/repository/review_repo.dart';
import 'package:flutter/material.dart';

class ReviewProvider extends ChangeNotifier {
  Future<List<Review>> getReview(int id) async {
    var response = await ReviewRepo().getReview(id);
    return response;
  }
}
