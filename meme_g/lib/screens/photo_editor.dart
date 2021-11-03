import 'package:flutter/material.dart';

class PhotoEditor extends StatefulWidget {

  static const route = 'photo_editor_screen';

  @override
  State<PhotoEditor> createState() => _PhotoEditorState();
}

class _PhotoEditorState extends State<PhotoEditor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('photo editor'),
        shadowColor: Colors.green,
      ),
      body: Container(
        child: Text('photo editor'),
      ),
    );
  }
}