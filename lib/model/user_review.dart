import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserReview {
  String movieID;
  String userID;
  String review;
  String rating;
  UserReview({
    required this.movieID,
    required this.userID,
    required this.review,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieID': movieID,
      'userID': userID,
      'review': review,
      'rating': rating,
    };
  }

  factory UserReview.fromMap(Map<String, dynamic> map) {
    return UserReview(
      movieID: map['movieID'] ?? "",
      userID: map['userID'] ?? "",
      review: map['review'] ?? "",
      rating: map['rating'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserReview.fromJson(String source) =>
      UserReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
