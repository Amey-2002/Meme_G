// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/services/database.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as Path;

class SaveUpload extends StatefulWidget {
  const SaveUpload({Key? key}) : super(key: key);
  static const route = 'Ssave_upload_scren';

  @override
  _SaveUploadState createState() => _SaveUploadState();
}

class _SaveUploadState extends State<SaveUpload> {
  /*late final img = NetworkImage('https://picsum.photos/1920/1080/');

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
              onPressed: () {
                Database(uid: 'GBJYs4RwedhbQ6oAKpigch1l8sy1').updateUserData(link: 'https://picsum.photos/1920/1080/');
              },
            ),
          ],
        ),
      ),
    );
  }*/
  File? _imageFile = null;
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference postedMemesRef;
  late CollectionReference memesCollectionRef;
  late CollectionReference usersCollectionRef;
  late String userName, userId;
  late firebase_storage.Reference ref;

  ///NOTE: Only supported on Android & iOS
  ///Needs image_picker plugin {https://pub.dev/packages/image_picker}
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    usersCollectionRef = FirebaseFirestore.instance.collection('Users');
    userId = user!.uid;
    usersCollectionRef
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          userName = documentSnapshot.get(FieldPath(['Username']));
        });
      }
    });
    memesCollectionRef = FirebaseFirestore.instance.collection('Memes');
    postedMemesRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('PostedMemeURLs');
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
  }

  Future _uploadImageToFirebase(BuildContext context) async {
    //Check Permissions
    await Permission.photos.request();
    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      //Uploading meme To Firebase
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Posted-Memes/${Path.basename(_imageFile!.path)}');
      await ref.putFile(_imageFile!).whenComplete(() async {
        await ref.getDownloadURL().then((value) async {
          //sending the received url of uploaded meme to firestore along with userName, userID
          await postedMemesRef.add({
            'url': value,
            'Username': userName,
            'UserID': userId,
            'DateTime': DateTime.now().microsecondsSinceEpoch.toString()
          });
          //Also storinging in a Memes Collection to use in top list
          await memesCollectionRef.add({
            'url': value,
            'Username': userName,
            'UserID': userId,
            'DateTime': DateTime.now().microsecondsSinceEpoch.toString()
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
      //print('Permission not granted. Try Again with permission access');
    }
  }

  /*Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(_imageFile!.path);
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance
        .ref().child(user!.uid+'Posted Memes').child('/$fileName');

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': fileName});
    firebase_storage.UploadTask uploadTask;
    //late StorageUploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask = ref.putFile(io.File(_imageFile!.path), metadata);

    firebase_storage.UploadTask task= await Future.value(uploadTask);
    Future.value(uploadTask).then((value) => {
    print("Upload file path ${value.ref.fullPath}")
    }).onError((error, stackTrace) => {
      print("Upload file path error ${error.toString()} ")
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(250.0),
                    bottomRight: Radius.circular(10.0)),
                gradient: LinearGradient(
                    colors: [Colors.green, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Uploading Image to Firebase Storage",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 10.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: _imageFile != null
                              ? Image.file(_imageFile!)
                              : FlatButton(
                                  child: Icon(
                                    Icons.add_a_photo,
                                    color: Colors.blue,
                                    size: 50,
                                  ),
                                  onPressed: pickImage,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                uploadImageButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadImageButton(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
            margin: const EdgeInsets.only(
                top: 30, left: 20.0, right: 20.0, bottom: 20.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange, Colors.green],
                ),
                borderRadius: BorderRadius.circular(30.0)),
            child: FlatButton(
              onPressed: () => _uploadImageToFirebase(context),
              child: Text(
                "Upload Image",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
