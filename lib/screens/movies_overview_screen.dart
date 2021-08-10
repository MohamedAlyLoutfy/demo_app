import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/movie.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:flutter_complete_guide/widgets/app_drawer.dart';
import 'package:flutter_complete_guide/widgets/movie_item.dart';
import '../providers/movies.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favorties,
  All,
}

class MoviesOverviewScreen extends StatefulWidget {
  static const routeName = '/movies';

  @override
  _MoviesOverviewScreenState createState() => _MoviesOverviewScreenState();
}

class _MoviesOverviewScreenState extends State<MoviesOverviewScreen> {
  List<Movie> mylastmovies = [];
  var _isLoading = false;
  var _isInit = true;
  var _showfavs = false;
  @override
  void initState() {
    start();

    super.initState();
  }

  Future<void> start() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
    }
    final myMovies = Provider.of<Movies>(context, listen: false);
    final userId = Provider.of<Auth>(context, listen: false).userId;
    await myMovies.fetchmovies2(userId);
    // mylastmovies=_showfavs ?myMovies.favoriteItems:myMovies.items;

    setState(() {
      _isLoading = false;
    });
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final myMovies = Provider.of<Movies>(context, listen: false);
    mylastmovies = _showfavs ? myMovies.favoriteItems : myMovies.items;

    /// final mylastmovies=myMovies.items;
    return Scaffold(
      appBar: AppBar(
        title: Text('MyMovies'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorties) {
                  _showfavs = true;
                } else {
                  _showfavs = false;
                }
              });
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only favorties'),
                  value: FilterOptions.Favorties),
              PopupMenuItem(child: Text('show all'), value: FilterOptions.All),
            ],
          ),
          FlatButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
              child: Text('logout'))
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView(
              padding: const EdgeInsets.all(25),
              children: mylastmovies
                  .map((catData) => ChangeNotifierProvider.value(
                        value: catData,
                        child: MovieItem(
                            catData.id,
                            catData.title,
                            catData.imageUrl,
                            catData.description,
                            catData.rating,
                            catData.link,
                            catData.isFavorite),
                      ))
                  .toList(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
            ),
    );
  }
}
