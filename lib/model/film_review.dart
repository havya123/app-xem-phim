import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FilmReview {
  String movieID;
  FilmReview({
    required this.movieID,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieID': movieID,
    };
  }

  factory FilmReview.fromMap(Map<String, dynamic> map) {
    return FilmReview(
      movieID: map['movieID'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory FilmReview.fromJson(String source) =>
      FilmReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
