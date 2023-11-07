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

class SearchScreen extends StatelessWidget {
  SearchScreen({this.controller, super.key});

  PersistentTabController? controller;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    TextEditingController searchController = TextEditingController();
    int page = 1;
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    void _onRefresh() async {
      context.read<SearchProvider>().getMovie(searchController.text);
      await Future.delayed(const Duration(milliseconds: 1000));

      refreshController.refreshCompleted();
    }

    void _onLoading() async {
      context
          .read<SearchProvider>()
          .getMovie(searchController.text, page: page + 1);
      await Future.delayed(const Duration(milliseconds: 1000));
      refreshController.loadComplete();
    }

    return Scaffold(
      body: Padding(
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
                searchController.text = p0;
                context.read<SearchProvider>().getMovie(searchController.text);
              },
            ),
            spaceHeight(context),
            Expanded(
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: const WaterDropHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = const Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = const CircularProgressIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = const Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = const Text("release to load more");
                      } else {
                        body = const Text("No more Data");
                      }
                      return body;
                    },
                  ),
                  controller: refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: StreamBuilder(
                      stream: context
                          .read<SearchProvider>()
                          .searchController
                          .stream,
                      builder: (context, snapshot) {
                        if (snapshot.data?['status'] == statusCode.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Center(
                              child: Image(
                            image: AssetImage(
                                "assets/img/search/Search cant be found.png"),
                          ));
                        }
                        List<Movie> movies =
                            snapshot.data?['data'] as List<Movie>;

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
                      })),
            ),

            // Consumer<SearchProvider>(
            //   builder: (context, value, child) {

            // const Image(
            //     image: AssetImage("assets/img/search/Search cant be found.png"))
          ],
        ),
      ),
    );
  }
}
