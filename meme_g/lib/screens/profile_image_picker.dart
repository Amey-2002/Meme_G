import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:meme_g/services/database.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';

dynamic uid = '';

class ProfilePage extends StatefulWidget {
  set setUid(uId) {
    uid = uId;
  }

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _pickedImage = null;
  late CollectionReference profileImgRef;
  late firebase_storage.Reference ref;
  String? profileImageUrl;

  bool uploading = false;

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
                child: Stack(
                  children: [
                    Container(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      child: (profileImageUrl != null)
                          ? ClipOval(child: Image.network(profileImageUrl!))
                          : ClipOval(
                              child: Image.network(
                                  'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
                            ),
                    ),
                    uploading
                        ? Center(
                            child: Text('Uploading...'),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ),
          ClipRRect(
            child: RaisedButton(
              color: Colors.green,
              child: Text(
                "Set Profile Picture",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async {
                await _showPickOptionsDialog(context);
              },
            ),
          )
        ],
      ),
    );
  }

  final picker = ImagePicker();
  _loadPicker(ImageSource source) async {
    PickedFile? picked = await picker.getImage(source: source);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(PickedFile picked) async {
    File? cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        activeControlsWidgetColor: Colors.green,
        statusBarColor: Colors.green,
        toolbarColor: Colors.green,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        _pickedImage = cropped;
      });
    }
    if (_pickedImage != null) {
      setState(() {
        uploading = true;
      });
      _uploadProfileImg(context).whenComplete(() {
        setState(() {
          uploading = false;
        });
      });
    }
  }

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

  Future _uploadProfileImg(BuildContext context) async {
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Profile-Image/${Path.basename(_pickedImage!.path)}');
      await ref.putFile(_pickedImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) async {
          await profileImgRef.doc(uid).set({'url': value});
          profileImgRef
              .doc(uid)
              .get()
              .then((DocumentSnapshot documentSnapshot) {
            if (documentSnapshot.exists) {
              setState(() {
                profileImageUrl = documentSnapshot.get(FieldPath(['url']));
              });
            }
          });
        });
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            Text('Permission not granted. Try Again with permission access'),
            FlatButton(
              color: Colors.green,
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ]),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    profileImgRef = FirebaseFirestore.instance.collection('ProfileImageURL');
    if (uid != '') {
      profileImgRef.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            profileImageUrl = documentSnapshot.get(FieldPath(['url']));
          });
        }
      });
    }
  }

}
