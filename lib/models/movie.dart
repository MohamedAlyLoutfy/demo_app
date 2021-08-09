import 'package:flutter/foundation.dart';

class Movie {
  final String id;

  final String title;
  final String imageUrl;
  final String description;


  const Movie({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,

  });
}
