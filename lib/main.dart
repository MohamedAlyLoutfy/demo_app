import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(
      create: (ctx)=>Auth(),
      ),],
      child: MaterialApp(
        title: 'Movies',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AuthScreen(),
        routes:{
              AuthScreen.routeName:(ctx) => AuthScreen(),
             
            
            }
      ),
    );
  }
}


