import 'package:flutter/material.dart';
import 'package:meme_g/screens/liked_memes.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/screens/my_work.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/services/authstate.dart';
import 'package:provider/src/provider.dart';
import 'package:meme_g/SettingsScreen/about.dart';
import 'package:meme_g/SettingsScreen/help.dart';
import 'package:meme_g/SettingsScreen/settings_page.dart';
import '../screens/account_details_screen.dart';
 bool userstate = false;
class NavDrawer extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 32,
          ),
          title: Text(
            'You',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, personal_info.route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.collections,
            size: 32,
          ),
          title: Text(
            'Posted Tickles',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, MyWork.route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
            size: 32,
          ),
          title: Text(
            'Liked Tickles',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, LikedMemes.route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 32,
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, SettingsPage.route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.info,
            size: 32,
          ),
          title: Text(
            'About',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, AboutScreen.route);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.help,
            size: 32,
          ),
          title: Text(
            'Help',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          onTap: () {
            Navigator.pushNamed(context, HelpScreen.route);
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
          onTap: () async {
            await context.read<Auth>().signout();
           //await Navigator.popAndPushNamed(context,signIn.route);
            await  Navigator.pushReplacementNamed(context,signIn.route);
            print("signed out");
            CircularProgressIndicator(backgroundColor: Colors.greenAccent,);
           // userstate=false;
            //Navigator.pop(context);
          },
        ),
      ]),
    );
  }
}
