import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/favourite_provider.dart';
import 'package:baitap08/provider/movie_provider.dart';
import 'package:baitap08/provider/review_provider.dart';
import 'package:baitap08/screen/detail/detail_tab.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.id, super.key});
  final int id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<ReviewProvider>().getReview(widget.id);
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: context.read<MovieProvider>().getMovieDetail(widget.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData) {
                return const Center(
                  child: Text("No data"),
                );
              } else {
                Movie? data = snapshot.data;
                return Column(
                  children: [
                    spaceHeight(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
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
                    SizedBox(
                      height: getHeight(context, height: 0.45),
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: getHeight(context, height: 0.3),
                            clipBehavior: Clip.hardEdge,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            )),
                            child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image:
                                  "https://image.tmdb.org/t/p/w500/${data!.backdrop}",
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.network(
                                      "https://static.thenounproject.com/png/504708-200.png"),
                            ),
                          ),
                          Consumer<FavouriteProvider>(
                            builder: (context, value, child) {
                              return Positioned(
                                  right: 0,
                                  child: LikeButton(
                                    isLiked: value.isSaved(widget.id),
                                    onTap: (isLiked) async {
                                      context
                                          .read<FavouriteProvider>()
                                          .addFavouriteItem(widget.id);
                                      context
                                          .read<FavouriteProvider>()
                                          .loadWatchList();
                                      return !isLiked;
                                    },
                                  ));
                            },
                          ),
                          Positioned(
                            left: getWidth(context),
                            bottom: getHeight(context),
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              height: getHeight(context, height: 0.23),
                              width: getWidth(context, width: 0.3),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.yellow),
                              child: FadeInImage.memoryNetwork(
                                fit: BoxFit.cover,
                                placeholder: kTransparentImage,
                                image:
                                    "https://image.tmdb.org/t/p/w500/${data.posterPath}",
                                imageErrorBuilder: (context, error,
                                        stackTrace) =>
                                    Image.network(
                                        "https://static.thenounproject.com/png/504708-200.png"),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 20,
                              right: 15,
                              child: SizedBox(
                                height: getHeight(context, height: 0.1),
                                width: getWidth(context, width: 0.6),
                                child: Text(
                                  data.title,
                                  style: textTheme.titleLarge,
                                ),
                              )),
                          Positioned(
                              right: getWidth(context),
                              bottom: getHeight(context, height: 0.17),
                              child: Container(
                                height: getHeight(context, height: 0.05),
                                width: getWidth(context, width: 0.2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xff252836)
                                        .withOpacity(0.8)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Image(
                                        image: AssetImage(
                                            "assets/img/detail/Star.png")),
                                    Text(
                                      data.voteRate.toString(),
                                      style: const TextStyle(
                                          color: Color(0xffFF8700)),
                                    ),
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              FontAwesomeIcons.calendar,
                              color: Color(0xff92929D),
                              size: 15,
                            ),
                            spaceWidth(context, width: 0.02),
                            Text(
                              data.releaseDate,
                              style: const TextStyle(
                                  color: Color(0xff92929D), fontSize: 12),
                            ),
                          ],
                        ),
                        spaceWidth(context, width: 0.08),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              FontAwesomeIcons.ticket,
                              color: Color(0xff92929D),
                              size: 15,
                            ),
                            spaceWidth(context, width: 0.02),
                            Text(
                              data.genres,
                              style: const TextStyle(
                                  color: Color(0xff92929D), fontSize: 12),
                            ),
                          ],
                        ),
                        spaceWidth(context, width: 0.08),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              FontAwesomeIcons.clock,
                              color: Color(0xff92929D),
                              size: 15,
                            ),
                            spaceWidth(context, width: 0.02),
                            Text(
                              "${data.runTime} Minutes",
                              style: const TextStyle(
                                  color: Color(0xff92929D), fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    spaceHeight(context),
                    DetailTab(movie: data)
                  ],
                );
              }
            }),
      ),
    );
  }
}
