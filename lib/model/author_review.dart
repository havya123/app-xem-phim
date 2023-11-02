import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthorReview {
  String name;
  String avatarPath;
  double rating;
  AuthorReview({
    required this.name,
    required this.avatarPath,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': name,
      'avatar_path': avatarPath,
      'rating': rating,
    };
  }

  factory AuthorReview.fromMap(Map<String, dynamic> map) {
    return AuthorReview(
      name: map['username'] ?? "",
      avatarPath: map['avatar_path'] ?? "",
      rating: map['rating'] ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthorReview.fromJson(String source) =>
      AuthorReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
