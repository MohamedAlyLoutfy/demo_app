import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Movie with ChangeNotifier {
  final String id;

  final String title;
  final String imageUrl;
  final String description;
  final String rating;
  final String link;
  bool isFavorite;
  


   Movie({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.rating,
    @required this.link,
    this.isFavorite=false,

  });
   void _setFavValue(bool newValue){
    isFavorite=newValue;
    notifyListeners();
  }

   Future <void> toggleFavoriteState ()async{
 
    isFavorite=!isFavorite;
    notifyListeners();
  


    }
  }
  

