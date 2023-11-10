import 'package:baitap08/model/user_review.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserReviewRepo {
  Future<void> postReview(
      String movieID, String phone, String review, String rating) async {
    try {
      FirebaseServices.reviewRef.doc(movieID).collection('review').doc().set(
          UserReview(
                  movieID: movieID,
                  userID: phone,
                  review: review,
                  rating: rating)
              .toMap());
    } catch (e) {
      print(e);
    }
  }
}
