import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  String username;
  String password;
  String name;
  String email;
  String address;
  String phone;
  String avatar;
  String? token;
  UserModel({
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.avatar,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'avatar': avatar,
      'token': token
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] ?? "",
      password: map['password'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      address: map['address'] ?? "",
      phone: map['phone'] ?? "",
      avatar: map['avatar'] ?? "",
      token: map['token'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
