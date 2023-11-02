import 'package:baitap08/model/caster.dart';
import 'package:baitap08/provider/caster_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class CasterTab extends StatelessWidget {
  const CasterTab({required this.id, super.key});
  final int id;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<CasterProvider>().getCaster(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.isNotEmpty) {
          List<Caster> casters = snapshot.data as List<Caster>;
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: casters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    clipBehavior: Clip.hardEdge,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image:
                          "https://image.tmdb.org/t/p/w500/${casters[index].avatar}",
                      imageErrorBuilder: (context, error, stackTrace) =>
                          const Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/img/detail/avatar.png"),
                      ),
                    ),
                  ),
                  Text(
                    casters[index].name,
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              );
            },
          );
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
