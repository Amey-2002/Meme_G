import 'package:flutter/material.dart';
import './meme_view.dart';

class MemeList extends StatelessWidget {
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
          MemeView(),
          MemeView(),
          MemeView(),
          MemeView(),
        ],
      ),
    );
  }
}
