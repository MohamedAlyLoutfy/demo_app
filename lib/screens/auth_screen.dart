import 'package:flutter/material.dart';
import 'dart:math';


enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
  
    return Scaffold(
      
      body:Container(
        decoration:BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/batman-the-dark-knight-wallpaper-preview.jpg"), fit: BoxFit.cover)) ,
        child:  Stack(
        
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                
                colors: [
                  Colors.yellow,
                  //Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
              
                  Color.fromRGBO(255, 0, 0, 0.5).withOpacity(0.1),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          
        ],
      )),
    );
  }
}


