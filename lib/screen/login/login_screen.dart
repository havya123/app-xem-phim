import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/alertDialog.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/provider/favourite_provider.dart';
import 'package:baitap08/provider/login_provider.dart';
import 'package:baitap08/provider/user_detail_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool hidePass = true;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: getHeight(context, height: 0.3),
                width: getWidth(context, width: 0.3),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/splash/splash_img.png")),
                ),
              ),
              spaceHeight(context),
              Text(
                "Login",
                style: textTheme.titleLarge,
              ),
              spaceHeight(context),
              TextFieldWidget(
                controller: phoneController,
                hint: 'Username',
                type: TextInputType.phone,
              ),
              spaceHeight(context),
              StatefulBuilder(builder: (context, setState) {
                return TextFieldWidget(
                  controller: passwordController,
                  hint: 'Password',
                  isPass: hidePass,
                  icon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePass = !hidePass;
                        });
                      },
                      icon: hidePass
                          ? const Icon(FontAwesomeIcons.eyeSlash)
                          : const Icon(FontAwesomeIcons.eye)),
                );
              }),
              spaceHeight(context, height: 0.06),
              ButtonWidget(
                function: () async {
                  await context
                      .read<LoginProvider>()
                      .login(
                        phoneController.text,
                        passwordController.text,
                      )
                      .then((value) async {
                    if (value != null) {
                      try {
                        await context
                            .read<FavouriteProvider>()
                            .loadListId(phoneController.text)
                            .then((value) async {
                          await context
                              .read<FavouriteProvider>()
                              .loadWatchList()
                              .then((value) {
                            context
                                .read<LoginProvider>()
                                .updatePhone(phoneController.text);
                          });
                        });
                      } catch (e) {
                        print(e);
                      }
                    } else {
                      ErrorDialog.showErrorDialog(
                          context, 'Tai khoan hoac mat khau khong dung');
                    }
                  });
                },
                textButton: "Login",
              ),
              spaceHeight(context),
              TextButton(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(
                        context, RouteName.signUpRoute);
                    if (result is Map) {
                      phoneController.text = result['phone'];
                      passwordController.text = result['password'];
                    }
                  },
                  child: const Text("Not have account yet? SignUp")),
            ],
          ),
        ),
      ),
    );
  }
}
