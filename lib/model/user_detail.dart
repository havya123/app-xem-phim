// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserDetail {
  String name;
  String email;
  String address;
  int phone;
  String? avatar;
  UserDetail({
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    this.avatar,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'avatar': avatar
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      address: map['address'] ?? "",
      phone: map['phone'] ?? 0,
      avatar: map['avatar'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) =>
      UserDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
