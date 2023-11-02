import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/provider/signUp_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:baitap08/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SecondSignup extends StatefulWidget {
  const SecondSignup({super.key});

  @override
  State<SecondSignup> createState() => _SecondSignupState();
}

class _SecondSignupState extends State<SecondSignup> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    bool showpass = true;
    bool showpass2 = true;

    void isHidden() {
      showpass = !showpass;
    }

    void isHidden2() {
      showpass2 = !showpass2;
    }

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
                      StatefulBuilder(
                        builder: (context, setState) {
                          return TextFieldWidget(
                            hint: 'Mật khẩu',
                            isPass: showpass,
                            icon: IconButton(
                              onPressed: () {
                                isHidden();
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
                              isHidden2();
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
                      await context
                          .read<SignUpProvider>()
                          .signUp(passController.text);
                      Navigator.pushNamedAndRemoveUntil(
                          context, RouteName.loginRoute, (route) => false);
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
