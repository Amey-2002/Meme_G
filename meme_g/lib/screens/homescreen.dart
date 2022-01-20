import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/SettingsScreen/settings_page.dart';
import 'package:meme_g/collage/collage_menu.dart';
import 'package:meme_g/collage/collage_screen.dart';
import 'package:meme_g/screens/editor/flutter_ie_pro.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/widgets/meme_list.dart';
import '../widgets/drawer.dart';
import '../screens/account_details_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);
  static const route = 'home_screen';
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  var appBar = AppBar(
      backgroundColor: appbarcolor ? Colors.grey.shade800 : Colors.white,
      foregroundColor: Colors.green,
      title: Image.asset(appbarcolor
          ? 'assets/dummyMemes/TicklesDarkAppBar.png'
          : 'assets/dummyMemes/Ticklesappbar.png')
      );

  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.green,
      title: Image.asset('assets/dummyMemes/Ticklesappbar.png')
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: (screenHeight - statusBarHeight - appBarHeight) * 0.09,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacementNamed(context, GridMenu.route);
              },
              label: const Text(
                'LET\'S TICKLE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                  ),
              ),
            ),
          ),
          Container(
            height: (screenHeight - statusBarHeight - appBarHeight) * 0.91,
            width: double.infinity,
            child: MemeList(),
          ),
        ],
      ),
    );
  }
}
