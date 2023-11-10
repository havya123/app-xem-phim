import 'package:baitap08/model/film_review.dart';
import 'package:baitap08/model/user_review.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilmReviewRepo {
  Future<void> createListReviews(String movieID) async {
    await FirebaseServices.reviewRef
        .doc(movieID)
        .set(FilmReview(movieID: movieID));
  }

  Future<List<UserReview>> getListReview(String movieID) async {
    var response = await FirebaseServices.reviewRef
        .doc(movieID)
        .collection('review')
        .get();
    List<UserReview> reviews =
        response.docs.map((doc) => UserReview.fromMap(doc.data())).toList();
    return reviews;
  }
}
