import 'dart:convert';

import 'package:baitap08/model/review.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ReviewRepo {
  Future<List<Review>> getReview(int id) async {
    final url =
        "https://api.themoviedb.org/3/movie/$id/reviews?language=en-US&page=1";

    final uri = Uri.parse(url);
    var response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer  ${dotenv.env['token']}'
    });
    Map<String, dynamic> data = jsonDecode(response.body);
    List listData = data["results"];
    List<Review> result =
        List<Review>.from(listData.map((e) => Review.fromJson(jsonEncode(e))))
            .toList();

    return result;
  }
}
