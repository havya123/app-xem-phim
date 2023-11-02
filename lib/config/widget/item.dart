import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Item extends StatelessWidget {
  Item({required this.id, required this.image, super.key});

  String image;
  int id;
  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: () {
          Navigator.of(context, rootNavigator: true)
              .pushNamed(RouteName.detailRoute, arguments: id);
        },
        child: Ink(
          child: FadeInImage.memoryNetwork(
              image: "https://image.tmdb.org/t/p/w500/$image",
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return const Image(
                    image: NetworkImage(
                        "https://thenounproject.com/api/private/icons/504708/edit/?backgroundShape=SQUARE&backgroundShapeColor=%23000000&backgroundShapeOpacity=0&exportSize=752&flipX=false&flipY=false&foregroundColor=%23000000&foregroundOpacity=1&imageFormat=png&rotation=0"));
              }),
        ),
      ),
    );
  }
}
