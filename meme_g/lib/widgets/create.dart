import 'package:flutter/material.dart';
import 'package:meme_g/screens/editor/flutter_ie_pro.dart';
import 'package:meme_g/screens/working/save_upload.dart';
import '../screens/editor/image_editor.dart';
import '../screens/editor/photo_editor.dart';

class Create extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FloatingActionButton.extended(onPressed: () {
                Navigator.pushNamed(context, ImageEditorPro.route);
              } , label:const Text(
                'LET\'S TICKLE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  //decoration: TextDecoration.underline,
                  fontSize: 30
                ),
              ), ),
            // FlatButton(
            //   onPressed: () {
            //     //Navigator.pushNamed(context, SaveUpload.route);
            //     //Navigator.pushReplacementNamed(context, ImageEditor.route);
            //     //Navigator.pushNamed(context, SaveUpload.route);
            //     //Navigator.pushNamed(context, ImageEditor.route);
            //     Navigator.pushNamed(context, ImageEditorPro.route);

            //     //Navigator.pushNamed(context, PhotoEditor.route);
            //     //Navigator.pushReplacementNamed(context, PhotoEditor.route);

            //   },
            //   child: const Text(
            //     'LET\'S TICKLE',
            //     style: TextStyle(
            //       color: Colors.green,
            //       fontWeight: FontWeight.bold,
            //       //decoration: TextDecoration.underline,
            //       fontSize: 30
            //     ),
            //   ),
            // ),
        
           /* Row(
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
            ),*/
          ],
        ),
      ),
    );
  }
}
