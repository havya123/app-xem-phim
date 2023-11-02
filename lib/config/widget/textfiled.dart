import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/provider/search_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {this.onChanged,
      required this.hint,
      this.icon,
      this.isPass = false,
      this.type = TextInputType.text,
      this.errorText,
      this.numberOfLetter,
      this.errorPass,
      this.minLetter = 0,
      this.controller,
      this.isPass1 = false,
      this.isConfirmPass = false,
      this.removeBorder = false,
      this.hintText = "",
      super.key});

  void Function(String)? onChanged;
  String hint;
  Widget? icon;
  bool isPass;
  TextInputType type;
  String? errorText;
  int? numberOfLetter;
  String? errorPass;
  int? minLetter;
  TextEditingController? controller;
  bool isPass1;
  bool isConfirmPass;
  bool removeBorder;
  String hintText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.go,
      onChanged: onChanged,
      controller: controller,
      keyboardType: type,
      obscureText: isPass,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(
          hint,
          style: const TextStyle(color: Colors.white),
        ),
        labelStyle: const TextStyle(color: Colors.black),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        errorBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        enabledBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        focusedBorder: OutlineInputBorder(
            borderSide: !removeBorder
                ? const BorderSide(color: Colors.black)
                : BorderSide.none,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        suffixIcon: icon,
      ),
    );
  }
}
