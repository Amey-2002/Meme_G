import 'package:flutter/material.dart';

class Text_fields extends StatefulWidget {
 
   dynamic  hintname="";
  Text_fields(this.hintname,cred);
  @override
  State<Text_fields> createState() => _Text_fieldsState();
}

class _Text_fieldsState extends State<Text_fields> {
  dynamic cred;
 
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      padding: EdgeInsets.all(5.0),
      height: 23.0,
      child: TextField(
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          hintText:widget.hintname,
        ),
        autofocus: false,
        scrollPadding: EdgeInsets.all(20.0),
        enableSuggestions: true,
        //strutStyle: StrutStyle(fontSize: double.infinity),
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.normal,  
        ),
        onChanged: (credential){
          setState(() {
            cred=credential;
          });
        },//expands: true,
      ),
    );
  }
}
