import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
      routes:{
            AuthScreen.routeName:(ctx) => AuthScreen(),
           
          
          }
    );
  }
}


