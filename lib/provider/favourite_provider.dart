import 'dart:convert';
import 'package:baitap08/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/movie_repo.dart';

class FavouriteProvider extends ChangeNotifier {
  List<int> favourieId = [];
  List<Movie> movies = [];

  void addFavouriteItem(int id) async {
    if (favourieId.contains(id)) {
      favourieId.remove(id);
      saveListId();
      notifyListeners();
    } else {
      favourieId.add(id);
      saveListId();
      notifyListeners();
    }
  }

  bool isSaved(int id) {
    return favourieId.contains(id) ? true : false;
  }

  void saveListId() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listId = favourieId.map((e) => jsonEncode(e)).toList();
    prefs.setStringList("listId", listId);
  }

  void loadListId() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? listData = prefs.getStringList("listId");
    if (listData != null) {
      favourieId = listData.map((e) => int.parse(e)).toList();
    } else {
      favourieId = [];
    }
    notifyListeners();
  }

  void loadWatchList() async {
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
