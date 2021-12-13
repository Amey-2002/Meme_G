import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/widgets/create.dart';
import 'package:meme_g/widgets/meme_list.dart';
import '../widgets/drawer.dart';
import 'editor/photo_editor.dart';
import '../screens/account_details_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);
  static const route = 'home_screen';
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    // final text = Provider.of<ThemeProvider>(context).themeMode ==ThemeMode.dark
    //     ? 'DarkTheme'
    //     : 'LightTheme';

    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.green,
          /*leading: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          radius: 36,
          backgroundImage: NetworkImage(
              'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
          // child: IconButton(
          //   onPressed: () {},
          //   icon: Icon(
          //     Icons.account_circle_sharp,
          //     color: Colors.white,
          //   ),
          //   iconSize: 40,
          // ),
        ),*/
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.account_circle_rounded),
          //   iconSize: 36,
          // ),
          title: Image.asset(
              'assets/dummyMemes/Ticklesappbar.png') /*Text(
          'Tickles',
          style: TextStyle(
            fontSize: 25,
          ),
        ),*/
          // backgroundColor: Colors.red[900],
          ),
      /*bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chats')),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {

                  Navigator.pushReplacementNamed(context,personal_info.route);

                //  Navigator.pushNamed(context, personal_info.route);

                },
              ),
              title: Text('You')),
        ],
      ),*/
      body: Container(
        height: double.infinity,
        child: Column(
          children: <Widget>[
            Create(),
            MemeList(),
          ],
        ),
      ),
    );
  }
}
