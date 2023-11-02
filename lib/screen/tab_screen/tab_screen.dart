import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/screen/tab_screen/widget/tab.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TabScreen extends StatefulWidget {
  TabScreen({required this.type, this.widget, super.key});
  List<String> type;
  Widget? widget;
  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  TextTheme textTheme = ThemeApp.themeApp.textTheme;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: widget.type.length,
      child: Column(
        children: [
          TabBar(
            indicatorColor: const Color(0xff3A3F47),
            indicatorWeight: 4.0,
            unselectedLabelStyle: textTheme.titleMedium,
            labelStyle: textTheme.titleSmall,
            isScrollable: true,
            tabs: widget.type.map((tab) => Tab(text: tab)).toList(),
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          spaceHeight(context),
          TabWidget(indexTab: _currentIndex),
        ],
      ),
    );
  }
}
