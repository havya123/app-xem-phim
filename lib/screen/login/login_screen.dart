import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/provider/favourite_provider.dart';
import 'package:baitap08/provider/login_provider.dart';
import 'package:baitap08/repository/user_login_repo.dart';
import 'package:baitap08/route/routes.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    TextEditingController phoneController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                onChanged: (p0) {
                  phoneController.text = "84$p0";
                },
                hint: 'Username',
              ),
              spaceHeight(context),
              TextFieldWidget(
                onChanged: (p0) {
                  passwordController.text = p0;
                },
                hint: 'Password',
              ),
              spaceHeight(context, height: 0.06),
              ButtonWidget(
                function: () {
                  context
                      .read<LoginProvider>()
                      .login(phoneController.text, passwordController.text, () {
                    print("Success");
                  }, () {
                    print("Error");
                  });
                  // context.read<FavouriteProvider>().loadListId();
                },
                textButton: "Login",
              ),
              spaceHeight(context),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.signUpRoute);
                  },
                  child: const Text("Not have account yet? SignUp")),
            ],
          ),
        ),
      ),
    );
  }
}
