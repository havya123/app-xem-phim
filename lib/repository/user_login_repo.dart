import 'package:baitap08/model/user.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserLoginRepo {
  var fireStore = FirebaseFirestore.instance;

  Future<UserModel> logIn(String phone) async {
    final users = await FirebaseServices.userRef
        .doc(phone)
        .get()
        .then((snapshot) => snapshot.data()!);
    return users;
  }
}
