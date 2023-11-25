import 'package:baitap08/config/size_config.dart';
import 'package:baitap08/model/video.dart';
import 'package:baitap08/provider/video_provider.dart';
import 'package:baitap08/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class OverViewTab extends StatefulWidget {
  OverViewTab({required this.id, required this.overView, super.key});
  int id;
  String overView;

  @override
  State<OverViewTab> createState() => _OverViewTabState();
}

class _OverViewTabState extends State<OverViewTab> {
  @override
  void initState() {
    super.initState();
    fectData();
  }

  Future<void> fectData() async {
    await context.read<VideoProvider>().getListVideo(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return SingleChildScrollView(
      child: Column(
        children: [
          Text(
            widget.overView,
            style: ThemeApp.themeApp.textTheme.titleMedium,
          ),
          spaceHeight(context),
          Consumer<VideoProvider>(builder: (context, value, child) {
            if (value.listVideo.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            YoutubePlayerController youtubePlayerController =
                YoutubePlayerController(
              initialVideoId: value.listVideo[index].key,
              flags: const YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            );
            return Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (index == 0) {
                          return;
                        }
                        index--;
                        youtubePlayerController
                            .load(value.listVideo[index].key);
                      },
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                    Column(
                      children: [
                        YoutubePlayer(
                          width: getWidth(context, width: 0.65),
                          controller: youtubePlayerController,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.amber,
                          progressColors: const ProgressBarColors(
                            playedColor: Colors.amber,
                            handleColor: Colors.amberAccent,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        if (value.listVideo.length == index + 1) {
                          return;
                        }
                        index++;
                        youtubePlayerController
                            .load(value.listVideo[index].key);
                      },
                      icon: const Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
                Text(
                  value.listVideo[index].name,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            );
          }),
          spaceHeight(context)
        ],
      ),
    );
  }
}
