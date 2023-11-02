import 'dart:convert';

import 'package:baitap08/model/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  Future<List<Movie>> getMoviesPopular(String type, int page) async {
    final url =
        "https://api.themoviedb.org/3/movie/$type?language=en-US&page=$page";
    final uri = Uri.parse(url);
    var response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer  ${dotenv.env['token']}'
    });

    Map<String, dynamic> listData = jsonDecode(response.body);
    List results = listData['results'];

    List<Movie> result =
        List<Movie>.from(results.map((e) => Movie.fromJson(jsonEncode(e))))
            .toList();

    return result;
  }

  Future<Movie?> getMovieDetail(int? id) async {
    final url = "https://api.themoviedb.org/3/movie/$id?language=en-US";
    final uri = Uri.parse(url);

    var response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer ${dotenv.env['token']}'
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> listData = jsonDecode(response.body);
      Movie result = Movie.fromJson(jsonEncode(listData));
      return result;
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      return null;
    }
  }
}
