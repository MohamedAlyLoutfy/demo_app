import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/movie.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/screens/movies_detail_screen.dart';
import 'package:provider/provider.dart';

class MovieItem  extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String desctiption;
  final String rating;
  final String link;

  MovieItem(this.id,this.title,this.imageUrl,this.desctiption,this.rating,this.link);
 
  @override
  Widget build(BuildContext context) {
    final movie =Provider.of<Movie>(context,listen: false);
    final userdata =Provider.of<Auth>(context,listen: false);
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: (){
              Navigator.of(context)
              .pushNamed(
                MovieDetailScreen.routeName,
                arguments:id, );
            
                },
            child:Hero(
              tag: Text('id'),
              child: FadeInImage(
                placeholder:  NetworkImage(
                  imageUrl),
                  image:NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                  ),
            ),
             
            ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
              leading:Consumer<Movie>(
                builder: (ctx,movie,_)=>  IconButton(
                  icon: Icon(
                  movie.isFavorite? Icons.favorite
                  :Icons.favorite_border),
                
                color: Theme.of(context).accentColor,
                onPressed: () {
                  movie.toggleFavoriteState();
                  
                },
                
                ),
              ),
   
            title: Text(
              title,
              textAlign: TextAlign.center,
              ),
              ),
        ),
    );
  }
}