// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:baitap08/model/author_review.dart';

class Review {
  AuthorReview authorReview;
  String content;
  String createdAt;
  Review({
    required this.authorReview,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'authorReview': authorReview.toMap(),
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      authorReview:
          AuthorReview.fromMap(map['author_details'] as Map<String, dynamic>),
      content: map['content'] ?? "",
      createdAt: map['created_at'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) =>
      Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
