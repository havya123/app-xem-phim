import 'dart:async';
import 'package:baitap08/enum/status_code.dart';
import 'package:baitap08/model/movie.dart';
import 'package:baitap08/repository/movie_repo.dart';
import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> topRatedMovies = [];
  List<Movie> upComingMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> nowPlayongMovies = [];

  StreamController<Map> recomendationMovies = StreamController<Map>.broadcast();
  Timer? timer;

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

  Future<Movie?> getMovieDetail(int id) async {
    var response = await MovieRepo().getMovieDetail(id);
    return response;
  }

  void getRecomendation(int id, int page) async {
    List<Movie> listMoviesRecomendation = [];
    timer?.cancel();

    timer = Timer(const Duration(seconds: 1), () async {
      if (page == 1) {
        recomendationMovies.add({'status': statusCode.loading, 'data': []});
        var response = await MovieRepo().getRecomendation(id, page);
        if (response.isNotEmpty) {
          listMoviesRecomendation = response;
          recomendationMovies.add(
              {'status': statusCode.success, 'data': listMoviesRecomendation});
        } else {
          recomendationMovies.add(
              {'status': statusCode.success, 'data': listMoviesRecomendation});
        }
      } else {
        var response = await MovieRepo().getRecomendation(id, page);
        listMoviesRecomendation.addAll(response);
        recomendationMovies.add(
            {'status': statusCode.success, 'data': listMoviesRecomendation});
      }
    });
  }

  @override
  void dispose() {
    recomendationMovies.close();
    super.dispose();
  }
}
