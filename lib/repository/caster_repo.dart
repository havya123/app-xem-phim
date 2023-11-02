import 'dart:convert';
import 'package:baitap08/model/caster.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CatersRepo {
  Future<List<Caster>> getCasters(int id) async {
    final url = "https://api.themoviedb.org/3/movie/$id/credits?language=en-US";
    final uri = Uri.parse(url);

    var response = await http.get(uri, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer  ${dotenv.env['token']}'
    });

    Map<String, dynamic> listData = jsonDecode(response.body);
    List results = listData["cast"];
    List<Caster> result =
        List<Caster>.from(results.map((e) => Caster.fromJson(jsonEncode(e))))
            .toList();
    return result;
  }
}
