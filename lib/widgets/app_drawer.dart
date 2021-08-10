import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/movies_overview_screen.dart';

import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer  extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children:<Widget> [
          AppBar(
            title: Text('Hello friend'),
            automaticallyImplyLeading: false,
            
            ),
            Divider(),
            ListTile(
              leading:Icon(Icons.star) ,
              title:Text('show only favs') ,
              onTap: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MoviesOverviewScreen(true)));
                
              },
              ),
              Divider(),
            ListTile(
              leading:Icon(Icons.content_copy) ,
              title:Text('show all') ,
              onTap: (){
              
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MoviesOverviewScreen(false)));
              },
              ),
               
                 Divider(),
            ListTile(
              leading:Icon(Icons.exit_to_app) ,
              title:Text('Logout') ,
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
<<<<<<< HEAD
                
=======
                //Navigator.of(context).pushReplacementNamed(UserProductsScreen.routeName);
>>>>>>> 462ffe105cc36ed05dcca9a212c8411d3500f66e
               Provider.of<Auth>(context,listen: false).logout();
              },

              ),






        ]
        
        
        ,),
      
    );
  }
}