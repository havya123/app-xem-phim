import 'package:baitap08/model/film_review.dart';
import 'package:baitap08/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
  static final reviewRef = FirebaseFirestore.instance
      .collection('reviews')
      .withConverter<FilmReview>(
        fromFirestore: (snapshot, options) =>
            FilmReview.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      );
}
