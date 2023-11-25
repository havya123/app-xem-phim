import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Video {
  String id;
  String name;
  String key;
  String publishedAt;
  Video({
    required this.id,
    required this.name,
    required this.key,
    required this.publishedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'key': key,
      'published_at': publishedAt,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      key: map['key'] ?? "",
      publishedAt: map['published_at'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Video.fromJson(String source) =>
      Video.fromMap(json.decode(source) as Map<String, dynamic>);
}
