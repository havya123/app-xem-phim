import 'dart:async';

import 'package:baitap08/repository/user_detail_repo.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetailProvider extends ChangeNotifier {
  XFile? selectedImage;
  StreamController loadingStatus = StreamController();
  String phone = "";

  Future<void> getPhone() async {
    final prefs = await SharedPreferences.getInstance();
    phone = prefs.getString('phone') ?? "";
    notifyListeners();
  }

  Future<void> updateName(String name) async {
    await UserDetailRepo().updateName(name, phone);
  }

  Future<void> updatePhone(String phone) async {
    await UserDetailRepo().updatePhone(phone, phone);
  }

  Future<void> updateAddress(String address) async {
    await UserDetailRepo().updateAddress(address, phone);
  }

  Future<void> updateEmail(String email) async {
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

  Future<void> saveImage() async {
    await UserDetailRepo().uploadAvatar(selectedImage, loadingStatus, phone);
  }

  @override
  void dispose() {
    loadingStatus.close();
    super.dispose();
  }
}
