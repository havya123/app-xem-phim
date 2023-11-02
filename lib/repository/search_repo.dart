import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SearchRepo {
  Future<List<int>> searchMovie(String keyword) async {
    final url =
        "https://api.themoviedb.org/3/search/movie?query=${keyword.replaceAll(" ", "+")}";
    final uri = Uri.parse(url);
    var response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer  ${dotenv.env['token']}'
    });

    Map<String, dynamic> data = jsonDecode(response.body);
    List listData = data["results"];
    List<int> listId = [];
    for (var result in listData) {
      int id = result['id'];
      listId.add(id);
    }
    return listId;
  }
}
