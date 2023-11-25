import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/search_item.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/enum/status_code.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/search_provider.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({this.controller, super.key});

  PersistentTabController? controller;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool shimmer = false;
  TextTheme textTheme = ThemeApp.themeApp.textTheme;
  TextEditingController searchController = TextEditingController();
  int page = 1;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> shimmerRefresh() async {
    setState(() {
      shimmer = true;
    });
    return Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        shimmer = false;
      });
    });
  }

  void _onLoading() async {
    context
        .read<SearchProvider>()
        .getMovie(searchController.text, page: page + 1);
    await Future.delayed(const Duration(seconds: 1));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      widget.controller!.jumpToTab(0);
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
                onChanged: (p0) async {
                  searchController.text = p0;
                  await context
                      .read<SearchProvider>()
                      .getMovie(searchController.text)
                      .then((value) {
                    shimmerRefresh();
                  });
                },
              ),
              spaceHeight(context),
              Expanded(
                  child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                header: const WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, mode) {
                    Widget body;
                    if (mode == LoadStatus.loading) {
                      body = const Center(child: CircularProgressIndicator());
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Center(child: Text("release to load more"));
                    } else {
                      body = const Center(child: Text("No more data"));
                    }
                    return body;
                  },
                ),
                controller: refreshController,
                onLoading: _onLoading,
                child: StreamBuilder(
                    stream:
                        context.read<SearchProvider>().searchController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                            child: Image(
                          image: AssetImage(
                              "assets/img/search/Search cant be found.png"),
                        ));
                      }

                      if (snapshot.data?['status'] == statusCode.loading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      if (snapshot.data!['data'].length == 0) {
                        return const Center(
                            child: Image(
                          image: AssetImage(
                              "assets/img/search/Search cant be found.png"),
                        ));
                      }
                      List<Movie> movies =
                          snapshot.data?['data'] as List<Movie>;

                      return shimmer
                          ? Shimmer.fromColors(
                              baseColor: Colors.white,
                              highlightColor: Colors.transparent,
                              child: Container(
                                child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      SearchItemWidget(
                                    id: movies[index].id,
                                    releaseDate: movies[index].releaseDate,
                                    genre: movies[index].genres,
                                    image: movies[index].posterPath,
                                    name: movies[index].title,
                                    rating: movies[index].voteRate,
                                    time: movies[index].runTime,
                                  ),
                                  itemCount: 5,
                                  separatorBuilder: (context, index) =>
                                      spaceHeight(context),
                                ),
                              ),
                            )
                          : ListView.separated(
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
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
