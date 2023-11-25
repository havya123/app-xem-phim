import 'dart:async';

import 'package:baitap08/repository/user_detail_repo.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailProvider extends ChangeNotifier {
  XFile? selectedImage;
  StreamController loadingStatus = StreamController.broadcast();

  Future<void> updateName(String name, String phone) async {
    await UserDetailRepo().updateName(name, phone);
  }

  Future<void> updatePhone(String newPhone, String phone) async {
    await UserDetailRepo().updatePhone(newPhone, phone);
  }

  Future<void> updateAddress(String address, String phone) async {
    await UserDetailRepo().updateAddress(address, phone);
  }

  Future<void> updateEmail(String email, String phone) async {
    await UserDetailRepo().updateEmail(email, phone);
  }

  Future<void> pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    selectedImage = returnImage;
  }

  Future<void> pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    selectedImage = returnImage;
  }

  Future<void> saveImage(String phone) async {
    await UserDetailRepo().uploadAvatar(selectedImage, loadingStatus, phone);
  }

  @override
  void dispose() {
    loadingStatus.close();
    super.dispose();
  }
}
