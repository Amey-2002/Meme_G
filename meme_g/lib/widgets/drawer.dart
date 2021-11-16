import 'package:flutter/material.dart';
import '../screens/account_details_screen.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle,size: 32,),
          title: Text(
            'You',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, Account_det.route);
          },
        ),
        ListTile(
          leading: Icon(Icons.collections,size: 32,),
          title: Text(
            'My Work',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.favorite,size: 32,),
          title: Text(
            'Liked Memes',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings,size: 32,),
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.info,size: 32,),
          title: Text(
            'About',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.help,size: 32,),
          title: Text(
            'Help',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {},
        ),
      ]),
    );
  }
}
