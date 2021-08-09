import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/movie.dart';
import 'package:flutter_complete_guide/widgets/movie_item.dart';
import '../providers/movies.dart';
import 'package:provider/provider.dart';


class MoviesOverviewScreen  extends StatelessWidget {
  static const routeName = '/movies';
  

  @override
  Widget build(BuildContext context) {
    final myMovies=Provider.of<Movies> (context);
    final mylastmovies=myMovies.items;
    return  Scaffold(

   body: GridView(
        padding: const EdgeInsets.all(25),
      children: mylastmovies
      .map((catData)=> MovieItem(
        catData.id,
        catData.title,
        catData.imageUrl,
        catData.description,


      )).toList(),



      
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
         maxCrossAxisExtent: 200,
         childAspectRatio: 3/2,
         crossAxisSpacing: 20,
         mainAxisSpacing: 20,


        ),


      
      
    ),
    );
   
  }
}