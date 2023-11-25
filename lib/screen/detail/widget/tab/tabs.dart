import 'package:baitap08/model/movie.dart';
import 'package:baitap08/screen/detail/widget/tab/cast.dart';
import 'package:baitap08/screen/detail/widget/tab/overview.dart';
import 'package:baitap08/screen/detail/widget/tab/recomendation.dart';
import 'package:baitap08/screen/detail/widget/tab/review.dart';
import 'package:flutter/material.dart';

class DetailTabs extends StatelessWidget {
  DetailTabs({required this.index, required this.movie, super.key});
  int index;
  Movie movie;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      OverViewTab(id: movie.id, overView: movie.overView),
      ReviewTab(
        movie: movie,
      ),
      CasterTab(id: movie.id),
      RecomendationTab(id: movie.id),
    ];
    return tabs[index];
  }
}
