import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/movie.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/movies.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailScreen extends StatefulWidget {
  static const routeName = '/details';

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  var _isfav;

  void _togglefavstate() {
    setState(() {
      _isfav = !_isfav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final movietId = ModalRoute.of(context).settings.arguments as String;
    final userdata = Provider.of<Auth>(context, listen: false);

    final loadedmovie = Provider.of<Movies>(
      context,
      listen: false,
    ).findById(movietId);
    _isfav = loadedmovie.isFavorite;
    return Scaffold(
      appBar: AppBar(
        title: Text('MyMovies'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              loadedmovie.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              loadedmovie.toggleFavoriteState(userdata.token, userdata.userId);
              setState(() {
                _togglefavstate();
              });
            },
          ),
         
        ],
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: loadedmovie.id,
                child: Image.network(
                  loadedmovie.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  loadedmovie.title,
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),

              SizedBox(
                height: 10,
              ),
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
                onRatingUpdate: (_) {},
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: new RichText(
                  text: new TextSpan(
                    children: [
                      new TextSpan(
                        text: 'To go to trailer, ',
                        style: new TextStyle(color: Colors.black),
                      ),
                      new TextSpan(
                        text: 'Click Here',
                        style: new TextStyle(color: Colors.blue),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launch(loadedmovie.link);
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
