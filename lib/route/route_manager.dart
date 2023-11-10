import 'package:baitap08/model/movie.dart';
import 'package:baitap08/route/routes.dart';
import 'package:baitap08/screen/detail/detail_screen.dart';
import 'package:baitap08/screen/error_screen/error_screen.dart';
import 'package:baitap08/screen/home_screen/home_screen.dart';
import 'package:baitap08/screen/list/list.dart';
import 'package:baitap08/screen/login/login_screen.dart';
import 'package:baitap08/screen/navigation/navigation_screen.dart';
import 'package:baitap08/screen/review_screen.dart/review_screen.dart';
import 'package:baitap08/screen/signup/second_signup_screen.dart';
import 'package:baitap08/screen/signup/signup_screen.dart';
import 'package:baitap08/screen/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class RouteManager {
  static Route routeManager(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashRoute:
        return pageTransition(const SplashScreen());
      case RouteName.homeRoute:
        return pageTransition(HomeScreen());
      case RouteName.navigationRoute:
        return pageTransition(const NavigationScreen());
      case RouteName.detailRoute:
        final arg = settings.arguments as int;
        return pageTransition(DetailScreen(id: arg));
      case RouteName.loginRoute:
        return pageTransition(const LoginScreen());
      case RouteName.listRoute:
        final arg = settings.arguments as String;
        return pageTransition(ListScreen(type: arg));
      case RouteName.signUpRoute:
        return pageTransition(const SignupScreen());
      case RouteName.secondSignUpRoute:
        final arg = settings.arguments as String;
        return pageTransition(SecondSignup(
          phone: arg,
        ));
      case RouteName.reviewRoute:
        final arg = settings.arguments as Movie;
        return pageTransition(ReviewScreen(
          movie: arg,
        ));
      default:
        return pageTransition(const ErrorScreen());
    }
  }

  static PageTransition<dynamic> pageTransition(Widget widget) {
    return PageTransition(child: widget, type: PageTransitionType.fade);
  }
}
