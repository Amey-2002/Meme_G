import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ie_edit_screen.dart';
import 'package:image_picker/image_picker.dart';

class ImageEditor extends StatefulWidget {
  static const route = 'image_editor_screen';

  @override
  State<ImageEditor> createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SelectBottomPanel()));
  }
}

class SelectBottomPanel extends StatefulWidget {
  const SelectBottomPanel({
    Key? key,
  }) : super(key: key);

  @override
  _SelectBottomPanelState createState() => _SelectBottomPanelState();
}

class _SelectBottomPanelState extends State<SelectBottomPanel> {
  late File _image;
  final picker = ImagePicker();
  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      Future.delayed(Duration(seconds: 0)).then(
        (value) => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditPhotoScreen(
              arguments: [_image],
            ),
          ),
        ),
      );
    }
  }

  //by shubham
  _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Pick from Gallery"),
              onTap: () {
                _loadPicker(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a picture"),
              onTap: () {
                _loadPicker(ImageSource.camera);
              },
            )
          ],
        ),
      ),
    );
  }

  _loadPicker(ImageSource source) async {
    //File picked = await ImagePicker.pickImage(source: source);
    PickedFile? picked =
        await picker.getImage(source: source /*ImageSource.camera*/);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
      Future.delayed(Duration(seconds: 0)).then(
        (value) => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (context) => EditPhotoScreen(
              arguments: [_image],
            ),
          ),
        ),
      );
    }
  }
  //

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Spacer(),
          Text(
            "Select image to edit",
            style: Theme.of(context).textTheme.headline4,
          ),
          Spacer(),
          //by shubham
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Pick from Gallery"),
                  onTap: () {
                    _loadPicker(ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.camera_alt),
                  title: Text("Take a picture"),
                  onTap: () {
                    _loadPicker(ImageSource.camera);
                  },
                )
              ],
            ),
          ),
          //original code
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        await _showPickOptionsDialog(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        height: MediaQuery.of(context).size.width / 2 / 0.6625,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 14,
                              height: MediaQuery.of(context).size.width /
                                  2 /
                                  0.6625,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                    width: 3),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Opacity(
                                    opacity: 1,
                                    child: Image.asset(
                                      'assets/dummyMemes/homescreen.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Theme.of(context).primaryColor,
                                          width: 1),
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.2),
                                      shape: BoxShape.circle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Icon(
                                      Icons.image,
                                      color: Theme.of(context).primaryColor,
                                      size: 40,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "Photos",
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),*/
          Spacer(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                "Select image, and edit them easily in a matter of seconds. Save or share them wherever and whenever you want.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).hintColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
