import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/movie.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/widgets/movie_item.dart';
import '../providers/movies.dart';
import 'package:provider/provider.dart';


class MoviesOverviewScreen  extends StatefulWidget {
  static const routeName = '/movies';

  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
   List<Movie> mylastmovies=[];
  
  @override
  Future <void> didChangeDependencies() async{
     final myMovies= Provider.of<Movies> (context,listen: false); 
      await myMovies.fetchmovies2();
       mylastmovies=myMovies.items;
       setState(() {
      
       });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    
     
   
   /// final mylastmovies=myMovies.items;
    return  Scaffold(
      appBar: AppBar(
        title:Text('MyMovies') ,
        actions:<Widget> [
          FlatButton(
            onPressed:(){
              
              Provider.of<Auth>(context,listen: false).logout();},
             child: Text('logout'))

        ],
        ),

   body: GridView(
        padding: const EdgeInsets.all(25),
      children:mylastmovies
      .map((catData)=> MovieItem(
        catData.id,
        catData.title,
        catData.imageUrl,
        catData.description,
        catData.rating,


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