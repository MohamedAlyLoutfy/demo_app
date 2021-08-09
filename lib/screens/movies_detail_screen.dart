import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/movies.dart';
import 'package:provider/provider.dart';
class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/details';
  

  @override
  Widget  build(BuildContext context) {
    final movietId=ModalRoute.of(context).settings.arguments as String;
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
                width:double.infinity ,
                child: Text(loadedmovie.description,
                textAlign: TextAlign.center,
                softWrap: true,
                
                ),
                ),
                SizedBox(height: 800,)
            ]) ,
          ),
        ],
      ),
    );
  }
}