import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/search_item.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/favourite_provider.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  "Watch list",
                  style: textTheme.titleLarge,
                ),
              ),
              spaceHeight(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Consumer<FavouriteProvider>(
                  builder: (context, value, child) {
                    List<Movie> movies = value.movies;
                    if (movies.isEmpty) {
                      return const Center(
                        child: Image(
                            image: AssetImage(
                                "assets/img/watch list/Empty Wishlist.png")),
                      );
                    }
                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SearchItemWidget(
                              id: movies[index].id,
                              image: movies[index].posterPath,
                              name: movies[index].title,
                              rating: movies[index].voteRate,
                              genre: movies[index].genres,
                              time: movies[index].runTime,
                              releaseDate: movies[index].releaseDate);
                        },
                        separatorBuilder: (context, index) =>
                            spaceHeight(context),
                        itemCount: value.movies.length);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
