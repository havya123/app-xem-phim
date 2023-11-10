import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/config/widget/button.dart';
import 'package:baitap08/config/widget/textfiled.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/provider/user_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key, required this.movie});
  Movie movie;

  @override
  Widget build(BuildContext context) {
    TextEditingController reviewController = TextEditingController();
    double rating = 3.5;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.orange,
                    )),
                SizedBox(
                  height: getHeight(context, height: 0.3),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          child: FadeInImage.memoryNetwork(
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image:
                                "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Image(
                                  image: AssetImage(
                                      "assets/img/detail/error_image.png"));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                spaceHeight(context, height: 0.02),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text(
                        "Rating film",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: StatefulBuilder(builder: (context, setState) {
                        return RatingBar.builder(
                          itemSize: 30,
                          initialRating: rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rate) {
                            setState(() {
                              rating = rate;
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
                spaceHeight(context),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                spaceHeight(context),
                Container(
                  width: double.infinity,
                  height: getHeight(context, height: 0.5),
                  color: Colors.grey.shade300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text("Hãy để lại đánh giá của bạn!"),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Form(
                        child: Expanded(
                          flex: 9,
                          child: TextFieldWidget(
                            hint: "",
                            removeBorder: true,
                            textColor: Colors.black,
                            controller: reviewController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spaceHeight(context),
                ButtonWidget(
                  function: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(
                          'Xác nhận gửi đánh giá?',
                          style: TextStyle(color: Colors.black),
                        ),
                        content: const Text(
                          'Bạn có muốn gửi đánh giá này không?',
                          style: TextStyle(color: Colors.black),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              await context
                                  .read<UserReviewProvider>()
                                  .postReview(movie.id.toString(),
                                      reviewController.text, rating.toString());
                              Navigator.pop(context);
                              showDialog<String>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    "Cảm ơn bạn đã gửi đánh giá",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  },
                  textButton: "Gửi đánh giá",
                ),
                spaceHeight(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
