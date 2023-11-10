import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  DialogWidget(
      {required this.textMg,
      required this.controller,
      required this.function,
      super.key});

  TextEditingController controller;
  Function function;
  String textMg;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      scrollable: true,
      title: Text(
        textMg,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.all(15),
      content: Column(
        children: [
          TextFieldWidget(
            hint: "",
            controller: controller,
            textColor: Colors.black,
          ),
          spaceHeight(context),
          ButtonWidget(
            function: () {
              function();
            },
            textButton: "Save",
          ),
          spaceHeight(context, height: 0.01),
          ButtonWidget(
            function: () {
              Navigator.pop(context);
            },
            textButton: "Exit",
          ),
        ],
      ),
    );
  }
}
