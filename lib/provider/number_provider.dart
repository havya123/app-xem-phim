import 'dart:async';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/repository/movie_repo.dart';
import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier {
  StreamController movieController = StreamController.broadcast();

  List<Movie> movies = [];

  void addStream(String type, {int page = 1}) async {
    if (page == 1) {
      var topRatedMovies = await MovieRepo().getMoviesPopular(type, page);
      movies.clear();
      movies.addAll(topRatedMovies);
      movieController.add(movies);
    } else {
      var topRatedMovies = await MovieRepo().getMoviesPopular(type, page);
      movies.addAll(topRatedMovies);
      movieController.add(movies);
    }
  }

  @override
  void dispose() {
    movieController.close();
    super.dispose();
  }
}
