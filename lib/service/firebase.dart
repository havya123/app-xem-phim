import 'package:baitap08/model/user.dart';
import 'package:baitap08/model/user_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static final userRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserModel>(
            fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          );
}
