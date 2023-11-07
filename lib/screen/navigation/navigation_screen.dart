import 'package:baitap08/screen/favourite/favourite_screen.dart';
import 'package:baitap08/screen/home_screen/home_screen.dart';
import 'package:baitap08/screen/profile/profile_screen.dart';
import 'package:baitap08/screen/search/search_screen.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

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
    const DetailProfileScreen()
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
        icon: const Icon(FontAwesomeIcons.person),
        inactiveColorPrimary: const Color(0xff67686D),
        activeColorPrimary: Colors.blue),
    // PersistentBottomNavBarItem(
    //     icon: const Icon(Icons.favorite),
    //     inactiveColorPrimary: const Color(0xff67686D),
    //     activeColorPrimary: Colors.blue),
  ];

  static final PersistentTabController controller = PersistentTabController();
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      backgroundColor: const Color(0xff242A32),
      context,
      screens: widgets,
      items: _barItem,
      controller: controller,
      resizeToAvoidBottomInset: true,
    );
  }
}
