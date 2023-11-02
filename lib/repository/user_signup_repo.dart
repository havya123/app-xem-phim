import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var fireStore = FirebaseFirestore.instance;

  int? phone;
  String? uid;

  Future<void> signUp(String password) async {
    User? user = _auth.currentUser;

    if (user != null) {
      var data = user.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
      uid = user.uid;
      if (data != null && data.isNotEmpty) {
        int phone = int.parse(data);
        await fireStore.collection("users").add({
          'id': uid,
          'phone': phone,
          'password': password,
        }).then((_) {
          print("User data saved to Firestore.");
        }).catchError((error) {
          print("Error saving user data: $error");
        });
      }
    }
    print("abc");
  }
}
