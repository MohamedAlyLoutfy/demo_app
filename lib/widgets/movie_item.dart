import 'package:flutter/material.dart';

class MovieItem  extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String desctiption;


  MovieItem(this.id,this.title,this.imageUrl,this.desctiption);



 
  @override
  Widget build(BuildContext context) {
    return InkWell(
     
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),

      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(title,
        
        style:Theme.of(context).textTheme.title,
        ),
        
      
      ),
    );
  }
}