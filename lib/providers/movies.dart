import 'dart:convert';

import 'package:http/http.dart' as http;
import '../database/db.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../models/movie.dart';

class Movies with ChangeNotifier {
  final String authToken;
  final String userId;
  Movies(
    this.authToken,
    this.userId,
  );
  List<Movie> _items = [];

  Future<void> fetchmovies2(String userId) async {
    //await getlocal();
    if (_items.isEmpty == false) {
      return;
    }
    for (int i = 500; i < 510; i++) {
      await fetchmovies(i.toString(), userId);
    }
   // getlocal();
  }

  List<Movie> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Future<void> fetchmovies(String id, String userId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$id?api_key=a2af4ebdd08882549dfd92280c0497ad';
    final response = await http.get(Uri.parse(url));

//print(json.decode(response.body)['vote_average']);
    String s1 = json.decode(response.body)['poster_path'];
    final url1 = 'http://image.tmdb.org/t/p/w185//' + s1;
    final movid = json.decode(response.body)['id'].toString();
    final urltr =
        'http://api.themoviedb.org/3/movie/$id/videos?api_key=a2af4ebdd08882549dfd92280c0497ad';
    final response2 = await http.get(Uri.parse(urltr));
    String jsonsDataString = response2.body.toString();
    final jsonData = jsonDecode(jsonsDataString);
    String link =
        'https://www.youtube.com/watch?v=' + jsonData['results'][0]['key'];

    ///print(link);
//print(url1);
    final url2 =
        'https://demoapp-90b94-default-rtdb.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
    final favoriteResponse = await http.get(Uri.parse(url2));
    final favoriteData = json.decode(favoriteResponse.body);
    //print(favoriteData[id]);
    final newMovie = Movie(
        id: json.decode(response.body)['id'].toString(),
        title: json.decode(response.body)['title'],
        imageUrl: url1,
        description: json.decode(response.body)['overview'],
        rating: json.decode(response.body)['vote_average'].toString(),
        link: link,
        isFavorite: favoriteData == null
            ? false
            : favoriteData[json.decode(response.body)['id'].toString()] ??
                false);

    _items.add(newMovie);
    if (favoriteData[id] == true) {
      await savelocal(id, userId, 'true');
    } else {
      await savelocal(id, userId, 'false');
    }

    //notifyListeners();
  }

  Movie findById(String id) {
    // print(_items.firstWhere((prod) => prod.id==id,));
    return _items.firstWhere(
      (prod) => prod.id == id,
    );
  }

  List<Movie> get items {
    return [..._items];
  }

  Future<void> savelocal(String movieid, String userid, String isfav) async {
    await DBHelper.insert(
        'user_movies', {'movieid': movieid, 'userid': userId, 'isfav': isfav});
  }

  Future<void> getlocal() async {
    final dataList = await DBHelper.getData('user_movies');
    //print('locaall');

    //print(dataList);
  }
}
