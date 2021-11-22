import 'package:flutter/material.dart';

class Text_fields extends StatelessWidget {
  dynamic  hintname="";
  Text_fields(this.hintname);

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: EdgeInsets.all(5.0),
      height: 23.0,
      child: TextField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText:hintname,
        ),
        autofocus: false,
        scrollPadding: EdgeInsets.all(20.0),
        enableSuggestions: true,
        //strutStyle: StrutStyle(fontSize: double.infinity),
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,
        ),
        //expands: true,
      ),
    );
  }
}
