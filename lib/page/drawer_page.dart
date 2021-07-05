import 'dart:ui';

import 'package:dictoryapp/page/favorite_page.dart';
import 'package:dictoryapp/page/home_page.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
              accountName: Center(
                child: Text(
                  "Hub of Word",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              accountEmail:
                  Center(child: Text("vinayvishwakarma920@gmail.com"))),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black,
              size: 26,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName, (route) => false);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.favorite,
              color: Colors.black,
              size: 26,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  FavroitePage.routeName, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
