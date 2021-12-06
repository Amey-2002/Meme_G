import 'package:flutter/material.dart';
import 'package:meme_g/abstract%20class/guest_meme_view.dart';

class GuestMemeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //use height if you use ListView.builder
      //height: 550, //435 for simulator & 550 for my mobile
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      //if ListView.builder is used then double double scrolling
      /*child: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return MemeView();
        },*/
      child: Column(
        children: <Widget>[
          GuestMemeView(
            img: Image.asset(
              'assets/dummyMemes/1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          GuestMemeView(
            img: Image.asset(
              'assets/dummyMemes/2.png',
              fit: BoxFit.cover,
            ),
          ),
          GuestMemeView(
            img: Image.asset(
              'assets/dummyMemes/3.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
