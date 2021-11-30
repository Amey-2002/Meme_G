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
//import 'package:permission_handler/permission_handler.dart';

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
  //late File _pickedImage;
  //File _pickedImage = File('C:/Users/shubh/Documents/GitHub/Meme_G/meme_g/lib/spare.txt');
  //Image(image: NetworkImage('https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'));

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
                        color: Colors.grey,
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
                //backgroundImage:,
                //_pickedImage != null ? FileImage(_pickedImage!) : null,
              ),
            ),
          ),
          //const SizedBox(height: 10.0),
          RaisedButton(
            child: Text("Set Profile Picture"),
            onPressed: () async {
              await _showPickOptionsDialog(context);
              
            },
          )
        ],
      ),
    );
  }

  final picker = ImagePicker();
  _loadPicker(ImageSource source) async {
    //File picked = await ImagePicker.pickImage(source: source);
    PickedFile? picked =
        await picker.getImage(source: source /*ImageSource.camera*/);
    if (picked != null) {
      _cropImage(picked);
    }
    Navigator.pop(context);
  }

  _cropImage(PickedFile picked) async {
    File? cropped = await ImageCropper.cropImage(
      androidUiSettings: AndroidUiSettings(
        statusBarColor: Colors.red,
        toolbarColor: Colors.red,
        toolbarTitle: "Crop Image",
        toolbarWidgetColor: Colors.white,
      ),
      sourcePath: picked.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        //CropAspectRatioPreset.original,
        //CropAspectRatioPreset.ratio16x9,
        //CropAspectRatioPreset.ratio4x3,
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

  Future _uploadProfileImg(BuildContext context) async {
    /*ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Profile-Image/${Path.basename(_pickedImage!.path)}');
    await ref.putFile(_pickedImage!).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        profileImgRef.add({'url': value});
      });
    });*/

    //Check Permissions
    /*await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {*/
      var snapshot = await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Profile-Image/${Path.basename(_pickedImage!.path)}')
          .putFile(_pickedImage!);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        profileImageUrl = downloadUrl;
      });
    /*} else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            children: <Widget>[
              Text(
                  'Permission not granted. Try Again with permission access'),
              FlatButton(
              child: Text(
                  'Ok'),
              onPressed: ()=>Navigator.pop(context),
            ),
            ]
          ),
        ),
      );
      //print('Permission not granted. Try Again with permission access');
    }*/
  }

  @override
  void initState() {
    super.initState();
    profileImgRef = FirebaseFirestore.instance.collection('ProfileImageURL');
  }

  /*Future _uploadImageToFirebase(BuildContext context) async {
    String fileName = Path.basename(_pickedImage!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref().child('Profile Photo').child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_pickedImage!.path), metadata);

    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
    print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });
  }*/

}
