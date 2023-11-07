import 'dart:convert';
import 'package:baitap08/model/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  Future<List<Movie>> searchMovie(String keyword, int page) async {
    final url =
        "https://api.themoviedb.org/3/search/movie?query=${keyword.replaceAll(" ", "+")}&page=$page";
    final uri = Uri.parse(url);
    var response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer  ${dotenv.env['token']}'
    });

    Map<String, dynamic> data = jsonDecode(response.body);
    List listData = data["results"];
    List<Movie> movies =
        List<Movie>.from(listData.map((e) => Movie.fromJson(jsonEncode(e))))
            .toList();
    return movies;
  }
}
