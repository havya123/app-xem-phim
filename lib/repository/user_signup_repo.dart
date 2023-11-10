import 'package:baitap08/model/user.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  Future<bool> isRegistered(String phone) async {
    var doc = await FirebaseServices.userRef.doc(phone).get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  void signUp(String phone, String password, String name, String email,
      String address) {
    FirebaseServices.userRef.doc(phone.toString()).set(UserModel(
          username: phone.toString(),
          password: password,
          name: name,
          email: email,
          address: address,
          phone: phone,
          avatar: "",
        ));
  }
}
