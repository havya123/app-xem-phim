import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/item.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/screen/detail/widget/tab/overview.dart';
import 'package:baitap08/screen/detail/widget/tab/review.dart';
import 'package:baitap08/screen/detail/widget/tab/tabs.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';

class DetailTab extends StatefulWidget {
  DetailTab({required this.movie, super.key});
  Movie movie;

  @override
  State<DetailTab> createState() => _DetailTabState();
}

class _DetailTabState extends State<DetailTab> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    List type = ["About Movie", "Review", "Cast", "Recomendation"];
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
          child: DefaultTabController(
        initialIndex: 0,
        length: type.length,
        child: Column(
          children: [
            TabBar(
              indicatorColor: const Color(0xff3A3F47),
              indicatorWeight: 4.0,
              unselectedLabelStyle: textTheme.titleMedium,
              labelStyle: textTheme.titleSmall,
              isScrollable: true,
              tabs: type.map((tab) => Tab(text: tab)).toList(),
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            spaceHeight(context),
            DetailTabs(
              movie: widget.movie,
              index: currentIndex,
            )
          ],
        ),
      )),
    );
  }
}
