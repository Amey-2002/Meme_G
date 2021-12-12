import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/wrapper.dart';

class splash_screen extends StatelessWidget {
  const splash_screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/dummyMemes/TicklesPhoneWallpaper.gif',
      nextScreen: Wrapper(),);
  }
}