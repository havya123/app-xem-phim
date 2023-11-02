import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/screen/navigation/navigation_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({required this.style, this.tabController, Key? key})
      : super(key: key);

  final TextStyle? style;
  final PersistentTabController? tabController;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        tabController!.jumpToTab(1);
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xff3A3F47),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Search",
                style: style,
              ),
              const Icon(
                Icons.search,
                color: Color(0xff67686D),
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
