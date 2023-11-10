import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/alertDialog.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/provider/signUp_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController verifyController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String verifyId = "";
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeight(context),
              const Text(
                'Đăng ký',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900),
              ),
              spaceHeight(context),
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        controller: phoneController,
                        hint: 'Nhập số điện thoại',
                        type: TextInputType.phone,
                        errorText: "Hãy nhập số điện thoại",
                        numberOfLetter: 10,
                        errorPass: "Yêu cầu nhập đủ 10 chữ số điện thoại",
                        minLetter: 10,
                      ),
                      spaceHeight(context, height: 0.015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: TextFieldWidget(
                            onChanged: (p0) {
                              verifyController.text = p0;
                            },
                            hint: 'Nhập mã OTP',
                            type: TextInputType.number,
                            errorText: "Hãy nhập mã OTP",
                            numberOfLetter: 6,
                            errorPass: "Mã OTP gồm 6 số",
                            minLetter: 6,
                          )),
                          spaceWidth(context),
                          Expanded(
                              child: GestureDetector(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                bool isRegistered = await context
                                    .read<SignUpProvider>()
                                    .isRegistered(phoneController.text);
                                if (isRegistered) {
                                  ErrorDialog.showErrorDialog(context,
                                      'So dien thoai da duoc dang ky ');
                                } else {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    phoneNumber: "+84${phoneController.text}",
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {},
                                    verificationFailed:
                                        (FirebaseAuthException e) {
                                      ErrorDialog.showErrorDialog(context,
                                          'Da co loi xay ra vui long thu lai ');
                                    },
                                    codeSent: (String verificationId,
                                        int? resendToken) {
                                      verifyId = verificationId;
                                      ErrorDialog.showErrorDialog(
                                          context, 'SMS da duoc gui');
                                    },
                                    codeAutoRetrievalTimeout:
                                        (String verificationId) {
                                      ErrorDialog.showErrorDialog(context,
                                          "Da co loi xay ra vui long thu lai");
                                    },
                                  );
                                }
                              }
                            },
                            child: Container(
                              width: double.infinity,
                              height: getHeight(context, height: 0.075),
                              decoration: BoxDecoration(
                                  color: const Color(0xff315EE7),
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  'Lấy mã OTP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  )),
              spaceHeight(context),
              ButtonWidget(
                function: () {
                  signUp(context, verifyId, verifyController, phoneController);
                },
                textButton: "Xác nhận",
              ),
              spaceHeight(context, height: 0.015),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, RouteName.loginRoute);
                  },
                  child: const Text(
                    '← Trở về đăng nhập',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signUp(
      context,
      String verifyId,
      TextEditingController verifyController,
      TextEditingController phoneController) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId,
        smsCode: verifyController.text,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushNamed(context, RouteName.secondSignUpRoute,
              arguments: phoneController.text)
          .then((value) => Navigator.pop(context, value));
    } catch (e) {
      ErrorDialog.showErrorDialog(context, "SMS is not correct");
    }
  }
}
