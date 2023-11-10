// ignore_for_file: use_build_context_synchronously

import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/provider/signUp_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SecondSignup extends StatefulWidget {
  SecondSignup({this.phone, super.key});
  String? phone;
  @override
  State<SecondSignup> createState() => _SecondSignupState();
}

class _SecondSignupState extends State<SecondSignup> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool showpass = true;
    bool showpass2 = true;

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController passController = TextEditingController();
    TextEditingController confirmpassController = TextEditingController();

    bool checkConfirm() {
      if (passController.text != confirmpassController.text) {
        confirmpassController.clear();
        return false;
      }
      if (passController.text == "" && confirmpassController.text == "") {
        return false;
      }
      return true;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: getWidth(context, width: 0.12),
                  height: getHeight(context, height: 0.06),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: const Icon(FontAwesomeIcons.arrowLeft),
                ),
              ),
              const Text(
                'Đăng ký thông tin',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFieldWidget(
                        hint: 'Họ và tên',
                        errorText: "Hãy nhập họ và tên",
                        controller: nameController,
                      ),
                      spaceHeight(context, height: 0.015),
                      TextFieldWidget(
                        hint: 'Địa chỉ',
                        controller: addressController,
                      ),
                      spaceHeight(context, height: 0.015),
                      TextFieldWidget(
                        hint: 'Email',
                        type: TextInputType.emailAddress,
                        errorText: "Hãy nhập Email",
                        controller: emailController,
                      ),
                      spaceHeight(context, height: 0.015),
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TextFieldWidget(
                            hint: 'Mật khẩu',
                            isPass: showpass,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpass = !showpass;
                                });
                              },
                              icon: Icon(
                                showpass
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                color: Colors.black,
                              ),
                            ),
                            errorText: "Hãy nhập mật khẩu",
                            errorPass: "Yêu cầu ít nhất 8 ký tự",
                            minLetter: 8,
                            controller: passController,
                            isPass1: true,
                          );
                        },
                      ),
                      spaceHeight(context, height: 0.015),
                      StatefulBuilder(builder: (context, setState) {
                        return TextFieldWidget(
                          hint: 'Xác nhận mật khẩu',
                          isPass: showpass2,
                          icon: IconButton(
                            onPressed: () {
                              setState(() {
                                showpass2 = !showpass2;
                              });
                            },
                            icon: Icon(
                              showpass2
                                  ? FontAwesomeIcons.eyeSlash
                                  : FontAwesomeIcons.eye,
                              color: Colors.black,
                            ),
                          ),
                          errorText: checkConfirm()
                              ? "Hãy xác nhận mật khẩu"
                              : "Mật khẩu không trùng khớp",
                          errorPass: "Yêu cầu ít nhất 8 ký tự",
                          minLetter: 8,
                          controller: confirmpassController,
                          isPass1: true,
                          isConfirmPass: true,
                        );
                      })
                    ],
                  )),
              spaceHeight(context, height: 0.05),
              ButtonWidget(
                function: () async {
                  if (checkConfirm()) {
                    if (formKey.currentState!.validate()) {
                      context.read<SignUpProvider>().signUp(
                            widget.phone as String,
                            passController.text,
                            nameController.text,
                            emailController.text,
                            addressController.text,
                          );
                      Navigator.pop(context, {
                        'phone': widget.phone,
                        'password': passController.text,
                      });
                    }
                  } else {
                    formKey.currentState!.validate();
                    return;
                  }
                },
                textButton: "Xác nhận",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
