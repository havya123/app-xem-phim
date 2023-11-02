import 'package:baitap08/model/movie.dart';
import 'package:baitap08/repository/movie_repo.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> topRatedMovies = [];
  List<Movie> upComingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> nowPlayongMovies = [];

  Future<void> getMoviesTopRated({int page = 1}) async {
    topRatedMovies = await MovieRepo().getMoviesPopular("top_rated", page);
    notifyListeners();
  }

  Future<void> getMoviesUpComing({int page = 1}) async {
    upComingMovies = await MovieRepo().getMoviesPopular("upcoming", page);

    notifyListeners();
  }

  Future<void> getMoviesPopular({int page = 1}) async {
    popularMovies = await MovieRepo().getMoviesPopular("popular", page);
    notifyListeners();
  }

  Future<void> getMoviesNowPlaying({int page = 1}) async {
    nowPlayongMovies = await MovieRepo().getMoviesPopular("now_playing", page);

    notifyListeners();
  }

  Future<Movie?> getMovieDetail(int? id) async {
    if (id != null) {
      var response = await MovieRepo().getMovieDetail(id);
      return response;
    }
    return null;
  }
}
