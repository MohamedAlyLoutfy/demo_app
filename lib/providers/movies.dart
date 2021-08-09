
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/movie.dart';
class Movies with ChangeNotifier{


List<Movie> _items=[] ;

Future<void> fetchmovies()async{

final  url= 'https://api.themoviedb.org/3/movie/550?api_key=a2af4ebdd08882549dfd92280c0497ad';
final response=await http.get(Uri.parse(url));

      final newMovie = Movie(
          id: json.decode(response.body)['id'].toString(),
          title:json.decode(response.body)['title'] ,
          imageUrl:null,
         
          description:json.decode(response.body)['overview']
           );
         _items.add(newMovie);
         //notifyListeners();


}


  List<Movie> get items{
     
    return[..._items];
  }









}