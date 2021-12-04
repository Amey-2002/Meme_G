import 'package:flutter/material.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/services/authstate.dart';
import 'package:provider/src/provider.dart';
import '../screens/account_details_screen.dart';
 bool userstate = false;
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
          onTap: () {
            
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_sharp,size: 32,),
          title: Text(
            'Log out',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            context.read<Auth>().signout();
            Navigator.popAndPushNamed(context,signIn.route);
            print("signed out");
           // userstate=false;
            //Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
