import 'dart:io';

import 'package:baitap08/model/user_detail.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailRepo {
  UserDetail? userDetail;
  var user = FirebaseAuth.instance.currentUser;
  final storage = FirebaseStorage.instance;

  Future<UserDetail?> getUserDetail() async {
    var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
    var response = await FirebaseServices.userRef
        .doc(data)
        .collection('userDetail')
        .doc(data)
        .get();
    UserDetail userDetail =
        UserDetail.fromMap(response.data() as Map<String, dynamic>);
    return userDetail;
  }

  Future<void> updateName(String name) async {
    var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
    final docUser =
        FirebaseServices.userRef.doc(data).collection('userDetail').doc(data);
    docUser.update({'name': name});
  }

  Future<void> updateEmail(String email) async {
    var user = FirebaseAuth.instance.currentUser;
    var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
    final docUser =
        FirebaseServices.userRef.doc(data).collection('userDetail').doc(data);
    docUser.update({'email': email});
  }

  Future<void> updatePhone(String phone) async {
    var user = FirebaseAuth.instance.currentUser;
    var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
    final docUser =
        FirebaseServices.userRef.doc(data).collection('userDetail').doc(data);
    docUser.update({'phone': phone});
  }

  Future<void> updateAddress(String address) async {
    var user = FirebaseAuth.instance.currentUser;
    var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
    final docUser =
        FirebaseServices.userRef.doc(data).collection('userDetail').doc(data);
    docUser.update({'address': address});
  }

  Future<void> updateAvatar(String avatar) async {
    var user = FirebaseAuth.instance.currentUser;
    var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
    final docUser =
        FirebaseServices.userRef.doc(data).collection('userDetail').doc(data);
    docUser.update({'avatar': avatar});
  }

  Future<void> uploadAvatar(XFile? imagePick) async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      var data = user!.phoneNumber?.replaceAll(RegExp(r'[^0-9]'), '');
      final path = '$data/${imagePick!.name}';
      final file = File(imagePick.path);

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImg = referenceRoot.child('images');
      Reference referenceImgToUpload = referenceDirImg.child(path);
      await referenceImgToUpload.putFile(File(file.path));
      String imageURL = await referenceImgToUpload.getDownloadURL();
      updateAvatar(imageURL);
      print(imageURL);
    } catch (e) {
      print(e);
    }
  }
}
