import 'dart:async';
import 'dart:io';
import 'package:baitap08/model/user.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailRepo {
  final storage = FirebaseStorage.instance;

  Future<void> updateName(String name, String phone) async {
    final docUser = FirebaseServices.userRef.doc(phone);
    await docUser.update({'name': name});
  }

  Future<void> updateEmail(String email, String phone) async {
    final docUser = FirebaseServices.userRef.doc(phone);
    await docUser.update({'email': email});
  }

  Future<void> updatePhone(String phoneChange, String phone) async {
    final docUser = FirebaseServices.userRef.doc(phone);
    await docUser.update({'phone': phoneChange});
  }

  Future<void> updateAddress(String phone, String address) async {
    final docUser = FirebaseServices.userRef.doc(phone);
    await docUser.update({'address': address});
  }

  Future<void> updateAvatar(String avatar, String phone) async {
    final docUser = FirebaseServices.userRef.doc(phone);
    await docUser.update({'avatar': avatar});
  }

  Future<void> uploadAvatar(
      XFile? imagePick, StreamController controller, String phone) async {
    try {
      final file = File(imagePick!.path);
      Reference referenceRoot = FirebaseStorage.instance.ref();
      final metadata = SettableMetadata(contentType: "image/jpeg");
      final uploadTask =
          referenceRoot.child("images/$phone.jpeg").putFile(file, metadata);
      uploadTask.snapshotEvents.listen(
        (TaskSnapshot taskSnapshot) async {
          switch (taskSnapshot.state) {
            case TaskState.running:
              final progress =
                  taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
              controller.add(progress);
              break;
            case TaskState.paused:
              break;
            case TaskState.canceled:
              break;
            case TaskState.error:
              break;
            case TaskState.success:
              String imageURL = await taskSnapshot.ref.getDownloadURL();
              await updateAvatar(imageURL, phone);
              break;
          }
        },
      );
      // await referenceImgToUpload.putFile(File(file.path));

      // print(imageURL);
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserModel>> getListUser(List<String> listID) async {
    List<UserModel> listUser = [];
    for (var id in listID) {
      var response = await FirebaseServices.userRef.doc(id).get();
      listUser.add(response.data() as UserModel);
    }
    return listUser;
  }
}
