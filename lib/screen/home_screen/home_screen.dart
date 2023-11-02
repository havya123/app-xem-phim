import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/search.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/movie_provider.dart';
import 'package:baitap08/screen/home_screen/widget/trending.dart';
import 'package:baitap08/screen/tab_screen/tab_screen.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.controller, super.key});
  PersistentTabController? controller;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    List<String> type = [
      "Now Playing",
      "Up Coming",
      "Top Rated",
      "Popular",
    ];
    return Scaffold(
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "What do you want to watch?",
            style: textTheme.titleLarge,
          ),
          Column(
            children: [
              spaceHeight(context),
              SearchWidget(
                  style: textTheme.labelMedium,
                  tabController: widget.controller),
              spaceHeight(context),
              SizedBox(
                height: getHeight(context, height: 0.4),
                child: const TrendingWidget(),
              ),
              spaceHeight(context),
              TabScreen(
                type: type,
              )
            ],
          )
        ]),
      ),
    ));
  }
}
