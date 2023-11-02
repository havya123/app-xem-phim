import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/search_item.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/search_provider.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({this.controller, super.key});

  PersistentTabController? controller;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    TextEditingController searchController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              spaceHeight(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      controller!.jumpToTab(0);
                    },
                    icon: const Icon(
                      Icons.keyboard_return,
                      size: 20,
                    ),
                    color: Colors.white,
                  ),
                  Text(
                    "Search",
                    style: textTheme.titleLarge,
                  ),
                  const Icon(
                    Icons.info_rounded,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
              spaceHeight(context),
              TextFieldWidget(
                hint: 'Search',
                onChanged: (p0) {
                  context.read<SearchProvider>().getMovie(p0);
                },
              ),
              spaceHeight(context),
              StreamBuilder(
                  stream:
                      context.read<SearchProvider>().searchController.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child: Image(
                        image: AssetImage(
                            "assets/img/search/Search cant be found.png"),
                      ));
                    }

                    List<Movie> movies = snapshot.data as List<Movie>;
                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => SearchItemWidget(
                        id: movies[index].id,
                        releaseDate: movies[index].releaseDate,
                        genre: movies[index].genres,
                        image: movies[index].posterPath,
                        name: movies[index].title,
                        rating: movies[index].voteRate,
                        time: movies[index].runTime,
                      ),
                      itemCount: movies.length,
                      separatorBuilder: (context, index) =>
                          spaceHeight(context),
                    );
                  })
              // Consumer<SearchProvider>(
              //   builder: (context, value, child) {

              // const Image(
              //     image: AssetImage("assets/img/search/Search cant be found.png"))
            ],
          ),
        ),
      ),
    );
  }
}
