import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/model/review.dart';
import 'package:baitap08/provider/review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewTab extends StatelessWidget {
  const ReviewTab({required this.id, super.key});
  final int id;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<ReviewProvider>().getReview(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.isNotEmpty) {
            List<Review> review = snapshot.data as List<Review>;
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
                            width: 100,
                            height: 100,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: FadeInImage.memoryNetwork(
                                imageErrorBuilder:
                                    (context, error, stackTrace) => const Image(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            "assets/img/detail/avatar.png")),
                                fit: BoxFit.cover,
                                placeholder: kTransparentImage,
                                image:
                                    "https://image.tmdb.org/t/p/w500/${review[index].authorReview.avatarPath}"),
                          ),
                          spaceHeight(context, height: 0.02),
                          Text(
                            review[index].authorReview.rating.toString(),
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
                              review[index].authorReview.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            spaceHeight(context, height: 0.02),
                            ReadMoreText(
                              review[index].content,
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
              itemCount: review.length,
            );
          } else {
            return const Center(
              child: Text("This Film has not any reviews yet"),
            );
          }
        });
  }
}
