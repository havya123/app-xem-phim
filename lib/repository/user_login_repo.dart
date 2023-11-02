import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserLoginRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  Future<void> logIn(String phone, String password, VoidCallback onSuccess,
      VoidCallback isError) async {
    final CollectionReference users = fireStore.collection('users');
    final QuerySnapshot result = await users
        .where('phone', isEqualTo: phone.replaceAll(RegExp(r'[^0-9]'), ''))
        .where('password', isEqualTo: password)
        .get();
    if (result.docs.isNotEmpty) {
      onSuccess();
    } else {
      isError();
    }
  }
}
