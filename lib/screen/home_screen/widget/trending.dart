import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/item.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrendingWidget extends StatelessWidget {
  const TrendingWidget({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> image = [
      "assets/img/home/1.png",
      "assets/img/home/2.png",
      "assets/img/home/3.png",
      "assets/img/home/4.png",
      "assets/img/home/5.png"
    ];
    return Consumer<MovieProvider>(builder: (context, value, child) {
      return ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                SizedBox(
                  height: getHeight(context, height: 0.35),
                  child: AspectRatio(
                    aspectRatio: 1.6 / 2,
                    child: Item(
                      id: value.topRatedMovies[index].id,
                      image:
                          "https://image.tmdb.org/t/p/w500/${value.topRatedMovies[index].posterPath}",
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Image(
                      image: AssetImage(image[index]),
                    )),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return spaceWidth(context);
          },
          itemCount: 5);
    });
  }
}
