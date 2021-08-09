import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/movies_detail_screen.dart';

class MovieItem  extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String desctiption;

  MovieItem(this.id,this.title,this.imageUrl,this.desctiption);
 
  @override
  Widget build(BuildContext context) {
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
              tag: id,
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
              leading:IconButton(
              icon: Icon(
                 Icons.favorite
                ),
              color: Theme.of(context).accentColor,
              onPressed: () {
                
              },
              
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