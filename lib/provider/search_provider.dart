import 'dart:async';

import 'package:baitap08/enum/status_code.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/repository/search_repo.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> movies = [];
  StreamController<Map> searchController = StreamController<Map>.broadcast();
  Timer? timer;

  Future<void> getMovie(String keyword, {int page = 1}) async {
    timer?.cancel();

    timer = Timer(const Duration(seconds: 1), () async {
      if (page == 1) {
        searchController.add({'status': statusCode.loading, 'data': []});
        var response = await SearchRepo().searchMovie(keyword, page);
        if (response.isNotEmpty) {
          movies.clear();
          movies = response;
          searchController.add({'status': statusCode.success, 'data': movies});
        } else {
          movies.clear();
          searchController.add({'status': statusCode.success, 'data': movies});
        }
      } else {
        var response = await SearchRepo().searchMovie(keyword, page);
        movies.addAll(response);
        searchController.add({'status': statusCode.success, 'data': movies});
      }
    });
  }

  @override
  void dispose() {
    searchController.close();
    super.dispose();
  }
}
