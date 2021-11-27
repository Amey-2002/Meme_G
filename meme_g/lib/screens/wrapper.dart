import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:provider/src/provider.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // return either homescreen or sign in page
     final user = context.watch<User?>();
    if (user == null) {
      return signIn();
    } else {
      return Homescreen();
    }
  }
}