import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  //Build the tiles on the Drawer
  Widget buildListTile(
      {@required String title, @required IconData icon, Function function}) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            //FontWeight.w700 is the value for bold.
            fontWeight: FontWeight.bold),
      ),
      onTap: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          SizedBox(height: 20),
          buildListTile(
            icon: Icons.restaurant,
            title: 'Meals',
            function: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTile(
              icon: Icons.settings,
              title: 'Settings',
              function: () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              }),
        ],
      ),
    );
  }
}
