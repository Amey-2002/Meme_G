import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/personal_info.dart';
import 'package:meme_g/widgets/create.dart';
import 'package:meme_g/widgets/guest_meme_list.dart';
import 'package:meme_g/widgets/meme_list.dart';
import '../widgets/drawer.dart';
import '../screens/editor/image_editor.dart';
import 'editor/photo_editor.dart';
import '../screens/account_details_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);
  static const route = 'home_screen';
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Meme Gen'),
      ),

      floatingActionButton:FloatingActionButton( //Floating action button on Scaffold
          backgroundColor: Colors.purpleAccent,
          onPressed: (){
           Navigator.pushNamed(context, ImageEditor.route);
      },
      child: Icon(Icons.add), //icon inside button
  ),

  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  //floating action button in the center 

  bottomNavigationBar: BottomAppBar( 
    //bottom navigation bar on scaffold
    
    shape: CircularNotchedRectangle(), //shape of notch
    notchMargin: 5, //notche margin between floating button and bottom appbar
    child: Row( //children inside bottom appbar
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
       
        IconButton(icon: Icon( Icons.home ), onPressed: () {},),
        IconButton(icon: Icon(Icons.account_circle), onPressed: () {
           Navigator.pushNamed(context,personal_info.route);
        },),
      //IconButton(icon: Icon(Icons.chat, color: Colors.white,), onPressed: () {},),
      ],
    ),
  ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Create(),
              (user == null) ? GuestMemeList() : MemeList(),
            ],
          ),
        ),
      ),
    );
  }
}
