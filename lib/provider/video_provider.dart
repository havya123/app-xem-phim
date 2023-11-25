import 'package:baitap08/model/video.dart';
import 'package:baitap08/repository/video_repo.dart';
import 'package:flutter/material.dart';

class VideoProvider extends ChangeNotifier {
  List<Video> listVideo = [];

  Future<void> getListVideo(int id) async {
    try {
      listVideo.clear();
      List<Video> videos = await VideoRepo().getListVideo(id);
      listVideo = videos;
      print(listVideo.length);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
