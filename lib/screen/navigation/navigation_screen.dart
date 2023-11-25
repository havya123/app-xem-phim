import 'package:baitap08/model/user.dart';
import 'package:baitap08/provider/login_provider.dart';
import 'package:baitap08/screen/favourite/favourite_screen.dart';
import 'package:baitap08/screen/home_screen/home_screen.dart';
import 'package:baitap08/screen/login/login_screen.dart';
import 'package:baitap08/screen/notification/notification_screen.dart';
import 'package:baitap08/screen/profile/profile_screen.dart';
import 'package:baitap08/screen/search/search_screen.dart';
import 'package:baitap08/service/firebase.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});
  @override
  State<NavigationScreen> createState() => _HomeState();
}

class _HomeState extends State<NavigationScreen> {
  List<Widget> widgets = [
    HomeScreen(controller: controller),
    SearchScreen(
      controller: controller,
    ),

    const FavouriteScreen(),
    const NotificationScreen(),
    DetailProfileScreen(
      controller: controller,
    ),

    // const WatchListScreen(),
  ];

  final List<PersistentBottomNavBarItem> _barItem = [
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        inactiveColorPrimary: const Color(0xff67686D),
        activeColorPrimary: Colors.blue),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        inactiveColorPrimary: const Color(0xff67686D),
        activeColorPrimary: Colors.blue),
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.list),
        inactiveColorPrimary: const Color(0xff67686D),
        activeColorPrimary: Colors.blue),
    PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications),
        inactiveColorPrimary: const Color(0xff67686D),
        activeColorPrimary: Colors.blue),
    PersistentBottomNavBarItem(
        icon: const Icon(FontAwesomeIcons.person),
        inactiveColorPrimary: const Color(0xff67686D),
        activeColorPrimary: Colors.blue),
  ];

  static final PersistentTabController controller = PersistentTabController();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, value, child) {
      if (value.userPhone.isEmpty) {
        return const LoginScreen();
      }
      return StreamProvider<UserModel?>.value(
        initialData: null,
        value: FirebaseServices.userRef
            .doc(value.userPhone)
            .snapshots()
            .map((event) {
          return event.data();
        }),
        builder: (context, child) {
          return PersistentTabView(
            backgroundColor: const Color(0xff242A32),
            context,
            screens: widgets,
            items: _barItem,
            controller: controller,
            resizeToAvoidBottomInset: true,
          );
        },
      );
    });
  }
}
