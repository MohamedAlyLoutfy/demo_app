import 'package:flutter/foundation.dart';

class Movie with ChangeNotifier {
  final String id;

  final String title;
  final String imageUrl;
  final String description;
  final String rating;
  bool isFavorite;
  


   Movie({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.rating,
    this.isFavorite=false,

  });

   void toggleFavoriteState (){
    isFavorite=!isFavorite;
    notifyListeners();
  }
}
