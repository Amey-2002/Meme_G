import 'dart:io';

//import 'package:coderjava_image_editor_pro/coderjava_image_editor_pro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_g/FlutterIEP/coderjava_image_editor_pro.dart';

class ImageEditorPro extends StatefulWidget {
  static const route = 'imageEditorProRoute';
  final List arguments;
  ImageEditorPro({required this.arguments});

  @override
  _ImageEditorProState createState() => _ImageEditorProState();
}

class _ImageEditorProState extends State<ImageEditorPro> {
  final controllerDefaultImage = TextEditingController();
  File? _defaultImage;
  File? _image;

  //late File image;
  @override
  void initState() {
    super.initState();
    _defaultImage = widget.arguments[0];
  }

  Future<void> getImageEditor() {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CoderJavaImageEditorPro(
            appBarColor: Colors.black87,
            bottomBarColor: Colors.black87,
            pathSave: null,
            defaultPathImage: _defaultImage == null ? '' : _defaultImage!.path,
            isShowingChooseImage: false,
            isShowingFlip: false,
            isShowingRotate: false,
            isShowingBlur: false,
            isShowingFilter: false,
            isShowingEmoji: false,
          );
        },
      ),
    ).then((value) {
      if (value != null) {
        setState(() {
          _image = value;
        });
      }
    }).catchError((er) {
      print(er);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Editor Pro Example',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            _image = null;
          });
        },
      ),
      body: condition(
        condition: _image == null,
        isTrue: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: controllerDefaultImage,
                  readOnly: true,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'No default image',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Set Default Image'),
                  onPressed: () async {
                    final imageGallery = await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (imageGallery != null) {
                      _defaultImage = File(imageGallery.path);
                      setState(() => controllerDefaultImage.text = _defaultImage!.path);
                    }
                  },
                ),
                ElevatedButton(
                  child: Text('Open Editor'),
                  onPressed: () {
                    getImageEditor();
                  },
                ),
              ],
            ),
          ),
        ),
        isFalse: _image == null
            ? Container()
            : Center(
                child: Image.file(_image!),
              ),
      ),
    );
  }

  Widget? condition({required bool condition, Widget? isTrue, Widget? isFalse}) {
    return condition ? isTrue : isFalse;
  }
}
