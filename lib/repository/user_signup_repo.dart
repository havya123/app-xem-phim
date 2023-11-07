import 'package:baitap08/model/user.dart';
import 'package:baitap08/model/user_detail.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  int? phone;
  String? uid;

  Future<bool> isRegistered(String phone) async {
    var doc =
        await FirebaseServices.userRef.doc("84${phone.substring(1)}").get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  }

  void signUp(String password, String name, String email, String address) {
    User? user = _auth.currentUser;

    if (user != null) {
      var data = user.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
      uid = user.uid;
      if (data != null && data.isNotEmpty) {
        int phone = int.parse(data);
        FirebaseServices.userRef
            .doc(phone.toString())
            .set(UserModel(
                id: uid as String,
                username: phone.toString(),
                password: password))
            .then((value) {
          FirebaseServices.userRef
              .doc(phone.toString())
              .collection("userDetail")
              .doc(phone.toString())
              .set(UserDetail(
                      name: name, email: email, address: address, phone: phone)
                  .toMap());
        });
      }
    }
  }
}
