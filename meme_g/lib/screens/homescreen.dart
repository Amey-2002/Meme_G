import 'package:flutter/material.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/widgets/create.dart';
import 'package:meme_g/widgets/meme_list.dart';
import '../widgets/drawer.dart';
import 'editor/photo_editor.dart';
import '../screens/account_details_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({ Key? key }) : super(key: key);
  static const route = 'home_screen'; 
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Meme Gen'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chats')),
          BottomNavigationBarItem(
              icon: IconButton(
                icon: Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushReplacementNamed(context,personal_info.route);
                },
              ),
              title: Text('You')),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Create(),
              MemeList(),
            ],
          ),
        ),
      ),
    );
  }
}