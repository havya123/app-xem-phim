import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Caster {
  int id;
  String name;
  String avatar;
  Caster({
    required this.id,
    required this.name,
    required this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
    };
  }

  factory Caster.fromMap(Map<String, dynamic> map) {
    return Caster(
      id: map['id'] as int,
      name: map['name'] ?? "",
      avatar: map['profile_path'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory Caster.fromJson(String source) =>
      Caster.fromMap(json.decode(source) as Map<String, dynamic>);
}
