/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';

/*class ProflieImagePicker extends StatefulWidget {
  static const route = 'profile_image_picker_screen';
  // This widget is the root of your application.
  @override
  State<ProflieImagePicker> createState() => _ProflieImagePickerState();
}

class _ProflieImagePickerState extends State<ProflieImagePicker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}*/

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late File _pickedImage ;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: CircleAvatar(
                  radius: 80,
                  child: _pickedImage == null ? Text("Picture") : null,
                  backgroundImage:
                      _pickedImage != null ? FileImage(_pickedImage) : null,
                ),
              ),
            ),
            //const SizedBox(height: 10.0),
            RaisedButton(
              child: Text("Pick Image"),
              onPressed: () {
                _showPickOptionsDialog(context);
              },
            )
          ],
        ),
    );
  }

  _loadPicker(ImageSource source) async {
    File picked = await ImagePicker.pickImage(source: source);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(File picked) async {
    File? cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });
    }
  }

  void _showPickOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("Pick from Gallery"),
              onTap: () {
                _loadPicker(ImageSource.gallery);
              },
            ),
            ListTile(
              title: Text("Take a pictuer"),
              onTap: () {
                _loadPicker(ImageSource.camera);
              },
            )
          ],
        ),
      ),
    );
  }
}*/