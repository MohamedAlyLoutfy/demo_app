
import 'package:flutter/foundation.dart';
import '../models/movie.dart';
class Movies with ChangeNotifier{
  List<Movie> _items=[
     Movie(
    id: 'c1',
    title: 'Movie1',
    imageUrl: null,
    description: 'this is movie'
  ),
     Movie(
    id: 'c2',
    title: 'Movie2',
    imageUrl: null,
    description: 'this is movie2'
  ),
     Movie(
    id: 'c3',
    title: 'Movie3',
    imageUrl: null,
    description: 'this is movie3'
  ),

  ];



  List<Movie> get items{

    return[..._items];
  }









}