import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/model/user.dart';
import 'package:baitap08/model/user_review.dart';
import 'package:baitap08/provider/film_review_provider.dart';
import 'package:baitap08/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewTab extends StatelessWidget {
  ReviewTab({required this.movie, super.key});
  Movie movie;
  @override
  Widget build(BuildContext context) {
    context.read<FilmReviewProvider>().getListReview(movie.id.toString());
    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
              onPressed: () async {
                await context
                    .read<FilmReviewProvider>()
                    .createListReview(movie.id.toString());
                Navigator.pushNamed(context, RouteName.reviewRoute,
                    arguments: movie);
              },
              child: const Text("Add your review")),
          Consumer<FilmReviewProvider>(
            builder: (context, value, child) {
              if (value.listReview.isNotEmpty) {
                List<UserReview> listReview = value.listReview;
                List<UserModel> listUser = value.listUser;
                return ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: FadeInImage.memoryNetwork(
                                    imageErrorBuilder: (context, error,
                                            stackTrace) =>
                                        const Image(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/img/detail/avatar.png")),
                                    fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    image: listUser[index].avatar),
                              ),
                              spaceHeight(context, height: 0.02),
                              Text(
                                listReview[index].rating.toString(),
                                style: const TextStyle(color: Colors.blue),
                              )
                            ],
                          ),
                        ),
                        spaceWidth(context, width: 0.02),
                        Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  listUser[index].name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                spaceHeight(context, height: 0.02),
                                ReadMoreText(
                                  listReview[index].review,
                                  style: const TextStyle(color: Colors.white),
                                  numLines: 3,
                                  readMoreText: "Read More",
                                  readLessText: "Read Less",
                                  readMoreTextStyle:
                                      const TextStyle(color: Colors.blue),
                                )
                              ],
                            ))
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => spaceHeight(context),
                  itemCount: listReview.length,
                );
              }

              return const Center(
                child: Text(
                  "This Film has not any reviews yet",
                  style: TextStyle(color: Colors.white),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
