import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/movies.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/details';
  

  @override
  Widget  build(BuildContext context) {
    final movietId=ModalRoute.of(context).settings.arguments as String;
    //print(movietId);

      final loadedmovie= Provider.of<Movies>(
     context,
     listen: false,
     ).findById(movietId);
    return Scaffold(
     
      body: CustomScrollView(
        slivers:<Widget> [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(loadedmovie.title),
              background:Hero(
                tag: loadedmovie.id,

                child: Image.network(loadedmovie.imageUrl,
                fit: BoxFit.cover,
                
                ),
              ),

              ),
          ),
          SliverList(
            delegate:SliverChildListDelegate([
              SizedBox(height: 10,),
         
            SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedmovie.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              //SizedBox(height: 800,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  'Ratings :' + loadedmovie.rating,
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                  softWrap: true,
                ),
              ),

             RatingBar(
                initialRating: (double.parse(loadedmovie.rating) * 5) / 10,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: Colors.amber,
                  ),
                  empty: Icon(
                    Icons.star_border,
                    color: Colors.amber,
                  ),
                ),
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              )


            ]) ,
          ),
        ],
      ),
    );
  }
}