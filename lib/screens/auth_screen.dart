import 'package:flutter/material.dart';

import 'package:flutter_complete_guide/widgets/authform.dart';


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
                image:NetworkImage('https://c4.wallpaperflare.com/wallpaper/542/142/560/batman-the-dark-knight-wallpaper-preview.jpg')
                 , fit: BoxFit.cover)) ,
        child:  Stack(
        
        children: <Widget>[
        
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                 
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
          
        ],
      )),
    );
  }
}


