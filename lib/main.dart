import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/movie.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/providers/movies.dart';
import 'package:flutter_complete_guide/screens/auth_screen.dart';
import 'package:flutter_complete_guide/screens/movies_detail_screen.dart';
import 'package:flutter_complete_guide/screens/movies_overview_screen.dart';
import 'package:flutter_complete_guide/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),

        //   ChangeNotifierProvider.value(
        // value:Movies(),
        // ),
        ChangeNotifierProxyProvider<Auth, Movies>(
          update: (ctx, auth, previousProducts) => Movies(
            auth.token,
            auth.userId,
          ),
          //create: (_)=>Products(),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                  title: 'Movies',
                  theme: ThemeData(
                    primarySwatch: Colors.purple,
                    accentColor: Colors.deepOrange,
                    fontFamily: 'Lato',
                  ),
                  home: auth.isAuth
                      ? MoviesOverviewScreen()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? SplashScreen()
                                  : AuthScreen(),
                        ),
                  routes: {
                    AuthScreen.routeName: (ctx) => AuthScreen(),
                    MoviesOverviewScreen.routeName: (ctx) =>
                        MoviesOverviewScreen(),
                    MovieDetailScreen.routeName: (ctx) => MovieDetailScreen(),
                  })),
    );
  }
}
