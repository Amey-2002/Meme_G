import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/SettingsScreen/settings_page.dart';
import 'package:meme_g/screens/editor/flutter_ie_pro.dart';
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
  var appBar = AppBar(
      backgroundColor: appbarcolor ? Colors.grey.shade800 : Colors.white,
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
          //     Icons.account_circle_sharp,q 
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
      title: Image.asset(appbarcolor
          ? 'assets/dummyMemes/TicklesDarkAppBar.png'
          : 'assets/dummyMemes/Ticklesappbar.png') /*Text(
          'Tickles',
          style: TextStyle(
            fontSize: 25,
          ),
        ),*/
      // backgroundColor: Colors.red[900],
      );

  var create = new Create();
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final appBarHeight = appBar.preferredSize.height;
    //final createHeight = MediaQuery(data: MediaQueryData, child: Create());
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
          //     Icons.account_circle_sharp,q 
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
      title: Image.asset('assets/dummyMemes/Ticklesappbar.png') /*Text(
          'Tickles',
          style: TextStyle(
            fontSize: 25,
          ),
        ),*/
      // backgroundColor: Colors.red[900],
      ),
      // AppBar(
      //     backgroundColor: appbarcolor? Colors.grey.shade800: Colors.white,
      //     foregroundColor: Colors.green,
      //     /*leading: CircleAvatar(
      //     backgroundColor: Colors.white,
      //     foregroundColor: Colors.white,
      //     radius: 36,
      //     backgroundImage: NetworkImage(
      //         'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
      //     // child: IconButton(
      //     //   onPressed: () {},
      //     //   icon: Icon(
      //     //     Icons.account_circle_sharp,
      //     //     color: Colors.white,
      //     //   ),
      //     //   iconSize: 40,
      //     // ),
      //   ),*/
      //     // IconButton(
      //     //   onPressed: () {},
      //     //   icon: Icon(Icons.account_circle_rounded),
      //     //   iconSize: 36,
      //     // ),
      //     title: Image.asset(
      //          appbarcolor?
      //          'assets/dummyMemes/TicklesDarkAppBar.png'
      //         :'assets/dummyMemes/Ticklesappbar.png') /*Text(
      //     'Tickles',
      //     style: TextStyle(
      //       fontSize: 25,
      //     ),
      //   ),*/
      //     // backgroundColor: Colors.red[900],
      //     ),
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
      body: Column(
        children: <Widget>[
          Container(
            height: (screenHeight - statusBarHeight - appBarHeight) * 0.09,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushReplacementNamed(context, ImageEditorPro.route);
              },
              label: const Text(
                'LET\'S TICKLE',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    //decoration: TextDecoration.underline,
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
