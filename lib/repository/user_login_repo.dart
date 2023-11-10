import 'package:baitap08/model/user.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserLoginRepo {
  var fireStore = FirebaseFirestore.instance;

  Future<UserModel> logIn(String phone) async {
    final users = await FirebaseServices.userRef
        .doc(phone)
        .get()
        .then((snapshot) => snapshot.data()!);
    return users;
  }

  Future<void> saveToken(String phone) async {
    var now = DateTime.now();
    var date = now.add(const Duration(days: 5));
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(date);
    final docUser = FirebaseServices.userRef.doc(phone);
    docUser.update({'token': formattedDate});
  }
}
