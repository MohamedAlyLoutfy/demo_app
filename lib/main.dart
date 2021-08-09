import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart' ;
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:flutter_complete_guide/screens/movies_overview_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
      value:Auth(),
      ),
      
      ],
      child:   Consumer<Auth>(
        builder:(ctx,auth,_)=>
       MaterialApp(
        title: 'Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:auth.isAuth?  AuthScreen() : MoviesOverviewScreen(),
        routes:{
              AuthScreen.routeName:(ctx) => AuthScreen(),
              MoviesOverviewScreen.routeName:(ctx) => MoviesOverviewScreen(),
             
            
            }
      )),
    );
  }
}


