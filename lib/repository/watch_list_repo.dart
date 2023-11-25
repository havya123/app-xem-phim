import 'package:baitap08/model/watch_list.dart';
import 'package:baitap08/service/firebase.dart';

class WatchListRepo {
  void saveWatchList(String phone, int movieId) {
    FirebaseServices.watchList
        .doc()
        .set(WatchList(movieId: movieId, userId: phone));
  }

  Future<bool> checkExist(String phone, int movieId) async {
    final film = await FirebaseServices.watchList
        .where('userId', isEqualTo: phone)
        .where('movieId', isEqualTo: movieId)
        .get();
    if (film.docs.isEmpty) {
      return true;
    }
    film.docs.first.reference.delete();
    return false;
  }

  Future<List<WatchList>> getWatchList(String phone) async {
    List<WatchList> listWatchList = [];
    await FirebaseServices.watchList
        .where('userId', isEqualTo: phone)
        .get()
        .then((value) => value.docs.forEach((element) {
              listWatchList.add(element.data());
            }));
    return listWatchList;
  }
}
