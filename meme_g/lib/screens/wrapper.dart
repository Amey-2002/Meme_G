import 'package:flutter/material.dart';
import 'package:meme_g/screens/sign_in_screen.dart';


class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // return either homescreen or sign in page
    return signIn();
  }
}