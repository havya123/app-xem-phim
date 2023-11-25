import 'dart:convert';

import 'package:baitap08/model/video.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class VideoRepo {
  Future<List<Video>> getListVideo(int id) async {
    try {
      final url =
          "https://api.themoviedb.org/3/movie/$id/videos?language=en-US";

      final uri = Uri.parse(url);

      var response = await http.get(uri, headers: {
        'accept': 'application/json',
        'Authorization': 'Bearer  ${dotenv.env['token']}'
      });

      Map<String, dynamic> data = jsonDecode(response.body);
      List listData = data['results'];
      List<Video> videos =
          List<Video>.from(listData.map((e) => Video.fromJson(jsonEncode(e))))
              .toList();

      return videos;
    } catch (e) {
      rethrow;
    }
  }
}
