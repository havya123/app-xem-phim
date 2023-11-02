import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/route/routes.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class SearchItemWidget extends StatelessWidget {
  SearchItemWidget(
      {required this.id,
      required this.image,
      required this.name,
      required this.rating,
      required this.genre,
      required this.time,
      required this.releaseDate,
      super.key});
  int id;
  String image;
  String name;
  double rating;
  String genre;
  int time;
  String releaseDate;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = ThemeApp.themeApp.textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(RouteName.detailRoute, arguments: id);
        },
        child: Ink(
          child: SizedBox(
            height: getHeight(context, height: 0.25),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(
                      height: double.infinity,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: "https://image.tmdb.org/t/p/w500/$image",
                        imageErrorBuilder: (context, error, stackTrace) =>
                            const Image(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              "https://thenounproject.com/api/private/icons/504708/edit/?backgroundShape=SQUARE&backgroundShapeColor=%23000000&backgroundShapeOpacity=0&exportSize=752&flipX=false&flipY=false&foregroundColor=%23000000&foregroundOpacity=1&imageFormat=png&rotation=0"),
                        ),
                      ),
                    )),
                Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              name,
                              style: textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 50,
                                        height: 50,
                                        child: Image(
                                            image: AssetImage(
                                                "assets/img/detail/Star.png")),
                                      ),
                                      spaceWidth(context),
                                      Text(
                                        rating.toString(),
                                        style: const TextStyle(
                                            color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            FontAwesomeIcons.ticket,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                      spaceWidth(context),
                                      Text(
                                        genre,
                                        style: textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            FontAwesomeIcons.calendar,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                      spaceWidth(context),
                                      Text(
                                        releaseDate,
                                        style: textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: Icon(
                                            FontAwesomeIcons.clock,
                                            color: Colors.white,
                                            size: 15,
                                          )),
                                      spaceWidth(context),
                                      Text(
                                        "$time Minutes",
                                        style: textTheme.titleMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
