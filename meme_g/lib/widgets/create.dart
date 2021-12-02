import 'package:flutter/material.dart';
import 'package:meme_g/screens/working/save_upload.dart';
import '../screens/image_editor.dart';
import '../screens/photo_editor.dart';

class Create extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, ImageEditor.route);
            },
            child: const Text(
              'LET\'S MEME',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                fontSize: 25
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 15,),
                padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Text('Search',
                    style: TextStyle(
                        fontSize: 20,
                    ),
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.search)),
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 15),
                //padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: InkWell(
                  child: Text('# Tags',
                    style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                  onTap: () {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15),
                //padding: const EdgeInsets.all(3.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Text('Browse',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
