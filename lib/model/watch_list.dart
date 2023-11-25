// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WatchList {
  int movieId;
  String userId;
  WatchList({
    required this.movieId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movieId': movieId,
      'userId': userId,
    };
  }

  factory WatchList.fromMap(Map<String, dynamic> map) {
    return WatchList(
      movieId: map['movieId'] ?? 0,
      userId: map['userId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory WatchList.fromJson(String source) =>
      WatchList.fromMap(json.decode(source) as Map<String, dynamic>);
}
