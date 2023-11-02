import 'dart:convert';

class Movie {
  int id;
  String posterPath;
  String title;
  String backdrop;
  String genres;
  double voteRate;
  String releaseDate;
  int runTime;
  String overView;
  Movie({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.backdrop,
    required this.genres,
    required this.voteRate,
    required this.releaseDate,
    required this.runTime,
    required this.overView,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'poster_path': posterPath,
      'title': title,
      'backdrop_path': backdrop,
      'genre': genres,
      'vote_average': voteRate,
      'release_date': releaseDate,
      'runtime': runTime,
      'overview': overView,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    final List listGenres = map['genres'] ?? [];
    if (!listGenres.isNotEmpty) {
      return Movie(
          id: map['id'] ?? 0,
          posterPath: map['poster_path'] ?? "",
          title: map['title'] ?? "",
          backdrop: map['backdrop_path'] ?? "",
          genres: "",
          voteRate: map['vote_average'].toDouble() ?? 0.0,
          releaseDate: map['release_date'] ?? "",
          runTime: map['runtime'] ?? 0,
          overView: map['overview'] ?? "");
    } else {
      Map<String, dynamic> genre = listGenres[0];
      return Movie(
          id: map['id'] ?? 0,
          posterPath: map['poster_path'] ?? "",
          title: map['title'] ?? "",
          backdrop: map['backdrop_path'] ?? "",
          genres: genre["name"] ?? "",
          voteRate: map['vote_average'].toDouble() ?? 0.0,
          releaseDate: map['release_date'] ?? "",
          runTime: map['runtime'] ?? 0,
          overView: map['overview'] ?? "");
    }
  }

  String toJson() => json.encode(toMap());

  factory Movie.fromJson(String source) =>
      Movie.fromMap(json.decode(source) as Map<String, dynamic>);
}
