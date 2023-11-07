import 'dart:io';

import 'package:baitap08/model/user_detail.dart';
import 'package:baitap08/repository/user_detail_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailProvider extends ChangeNotifier {
  UserDetail? userDetail;

  XFile? selectedImage;

  Future<void> getUserDetail() async {
    try {
      var response = await UserDetailRepo().getUserDetail();
      userDetail = response;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateName(String name) async {
    await UserDetailRepo().updateName(name);
    await getUserDetail();
  }

  Future<void> updatePhone(String phone) async {
    await UserDetailRepo().updatePhone(phone);
    await getUserDetail();
  }

  Future<void> updateAddress(String address) async {
    await UserDetailRepo().updateAddress(address);
    await getUserDetail();
  }

  Future<void> updateEmail(String email) async {
    await UserDetailRepo().updateEmail(email);
    await getUserDetail();
  }

  Future<void> pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    selectedImage = returnImage;
    notifyListeners();
  }

  Future<void> pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    selectedImage = returnImage;
    notifyListeners();
  }

  Future<void> saveImage() async {
    await UserDetailRepo().uploadAvatar(selectedImage);
    await getUserDetail();
  }
}
