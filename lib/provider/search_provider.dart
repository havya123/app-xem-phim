import 'dart:async';

import 'package:baitap08/model/movie.dart';
import 'package:baitap08/repository/movie_repo.dart';
import 'package:baitap08/repository/search_repo.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Movie> movies = [];
  StreamController<List<Movie>> searchController = StreamController();
  Timer? timer;

  void getMovie(String keyword) {
    timer?.cancel();
    movies.clear();

    timer = Timer(const Duration(seconds: 1), () async {
      var response = await SearchRepo().searchMovie(keyword);
      for (var id in response) {
        Movie? movie = await MovieRepo().getMovieDetail(id);
        if (movie != null) {
          movies.add(movie);
          searchController.add(movies);
        }
      }
    });
  }
}
