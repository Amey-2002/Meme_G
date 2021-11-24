// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SaveUpload extends StatefulWidget {
  const SaveUpload({Key? key}) : super(key: key);
  static const route = 'Ssave_upload_scren';

  @override
  _SaveUploadState createState() => _SaveUploadState();
}

class _SaveUploadState extends State<SaveUpload> {
  late final img = NetworkImage('https://picsum.photos/1920/1080/');

  /*@override
  void initState() {
    // TODO: implement initState
    super.initState();
    initBackground();
  }

  /// Fetches image from an [ImageProvider] (in this example, [NetworkImage])
  /// to use it as a background
  void initBackground() async {
    // Extension getter (.image) to get [ui.Image] from [ImageProvider]
    img = await NetworkImage('https://picsum.photos/1920/1080/');
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save/Upload'),
        shadowColor: Colors.green,
      ),
      body: Container(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                child: Image(image: img),
              ),
            ),
            RaisedButton(
              child: Text('Save in Gallery'),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text('Post as Meme'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
