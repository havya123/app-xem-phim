import 'package:baitap08/config/widget/item.dart';
import 'package:baitap08/config/widget/search_item.dart';
import 'package:baitap08/enum/status_code.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecomendationTab extends StatefulWidget {
  const RecomendationTab({required this.id, super.key});
  final int id;

  @override
  State<RecomendationTab> createState() => _RecomendationTabState();
}

class _RecomendationTabState extends State<RecomendationTab> {
  @override
  void initState() {
    super.initState();
    fectData();
  }

  int page = 1;
  final RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  void fectData() {
    context.read<MovieProvider>().getRecomendation(widget.id, page);
  }

  void _onLoading() async {
    context.read<MovieProvider>().getRecomendation(widget.id, page + 1);
    await Future.delayed(const Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SmartRefresher(
          enablePullDown: false,
          enablePullUp: true,
          header: const WaterDropHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, mode) {
              Widget body;
              if (mode == LoadStatus.loading) {
                body = const Center(
                  child: CircularProgressIndicator(),
                );
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
          onLoading: _onLoading,
          child: StreamBuilder(
              stream: context.read<MovieProvider>().recomendationMovies.stream,
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.data?['status'] == statusCode.loading) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (snapshot.data!['data'].isNotEmpty) {
                  List<Movie> movies = snapshot.data?['data'] as List<Movie>;

                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 1.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return Item(
                        image: movies[index].posterPath,
                        id: movies[index].id,
                      );
                    },
                    itemCount: movies.length,
                  );
                }

                return const Center(
                    child: Image(
                  image:
                      AssetImage("assets/img/search/Search cant be found.png"),
                ));
              })),
    );
  }
}
