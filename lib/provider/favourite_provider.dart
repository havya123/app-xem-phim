import 'package:baitap08/model/movie.dart';
import 'package:baitap08/model/watch_list.dart';
import 'package:baitap08/repository/watch_list_repo.dart';
import 'package:flutter/material.dart';
import '../repository/movie_repo.dart';

class FavouriteProvider extends ChangeNotifier {
  List<int> favourieId = [];
  List<Movie> movies = [];

  void addFavouriteItem(String userPhone, int id) async {
    if (favourieId.contains(id)) {
      favourieId.remove(id);
      saveListId(userPhone, id);
      notifyListeners();
    } else {
      favourieId.add(id);
      saveListId(userPhone, id);
      notifyListeners();
    }
  }

  bool isSaved(int id) {
    return favourieId.contains(id) ? true : false;
  }

  void saveListId(String userPhone, int id) async {
    bool isExist = await WatchListRepo().checkExist(userPhone, id);
    if (isExist == false) {
      return;
    }
    WatchListRepo().saveWatchList(userPhone, id);
  }

  Future<void> loadListId(String phone) async {
    List<WatchList> listWatchList = await WatchListRepo().getWatchList(phone);
    if (listWatchList.isNotEmpty) {
      favourieId = listWatchList.map((e) => e.movieId).toList();
    } else {
      favourieId = [];
    }
    notifyListeners();
  }

  Future<void> loadWatchList() async {
    movies.clear();
    if (favourieId.isNotEmpty) {
      for (var id in favourieId) {
        Movie? movie = await MovieRepo().getMovieDetail(id);
        if (movie != null && !movies.contains(movie)) {
          movies.add(movie);
        }
      }
    }
    notifyListeners();
  }
}
