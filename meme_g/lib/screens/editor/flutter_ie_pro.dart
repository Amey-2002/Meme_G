import 'dart:io';

//import 'package:coderjava_image_editor_pro/coderjava_image_editor_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_g/FlutterIEP/coderjava_image_editor_pro.dart';
import 'package:share/share.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class ImageEditorPro extends StatefulWidget {
  static const route = 'imageEditorProRoute';
  //final List arguments;
  //ImageEditorPro({required this.arguments});

  @override
  _ImageEditorProState createState() => _ImageEditorProState();
}

class _ImageEditorProState extends State<ImageEditorPro> {
  final controllerDefaultImage = TextEditingController();
  File? _defaultImage;
  File? _image;

  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference postedMemesRef;
  late CollectionReference memesCollectionRef;
  late CollectionReference usersCollectionRef;
  late String userName, userId;
  late firebase_storage.Reference ref;

  late String likedMemeDoc;
  late String likedMemeDocFinal;

  //late File image;
  @override
  void initState() {
    super.initState();
    //_defaultImage = widget.arguments[0];
    usersCollectionRef = FirebaseFirestore.instance.collection('Users');
    if (user != null) {
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
    } else {
      userId = '';
      userName = '';
    }
    memesCollectionRef = FirebaseFirestore.instance.collection('Memes');
    if (user != null) {
      postedMemesRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('PostedMemeURLs');
    } else {
      postedMemesRef = FirebaseFirestore.instance.collection('Users');
    }
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

  //
  final picker = ImagePicker();
  _loadPicker(ImageSource source) async {
    //File picked = await ImagePicker.pickImage(source: source);
    PickedFile? picked =
        await picker.getImage(source: source /*ImageSource.camera*/);
    if (picked != null) {
      _cropImage(picked);
      //_defaultImage = File(picked.path);
      //setState(() => controllerDefaultImage.text = _defaultImage!.path);
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
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio16x9,
        CropAspectRatioPreset.ratio4x3,
      ],
      maxWidth: 800,
    );
    if (cropped != null) {
      setState(() {
        //_pickedImage = cropped;
        _defaultImage = cropped;
        if (_defaultImage != null) {
          setState(() => controllerDefaultImage.text = _defaultImage!.path);
        }
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

  @override
  Widget build(BuildContext context) {
    /*setState(() {
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
    });*/

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Image Editor',
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
                    hintText: 'No image selected',
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  child: Text('Select Image to edit'),
                  onPressed: () async {
                    _showPickOptionsDialog(context);
                    // final imageGallery = await ImagePicker()
                    //     .pickImage(source: ImageSource.gallery);
                    // if (imageGallery != null) {
                    //   _defaultImage = File(imageGallery.path);
                    //   setState(() =>
                    //       controllerDefaultImage.text = _defaultImage!.path);
                    //}
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
            : Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Center(
                      heightFactor: 370,
                      widthFactor: 370,
                      child: Image.file(_image!),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await GallerySaver.saveImage(_image!.path,
                          albumName: "Tickle");
                    },
                    child: Text('Save to Gallery'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final RenderBox? box =
                          context.findRenderObject() as RenderBox;
                      if (Platform.isAndroid) {
                        Share.shareFiles([_image!.path],
                            text: (user == null)
                                ? (' ')
                                : ('Tickle shared by ' + userName),
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size);
                      } else {
                        Share.share(
                            (user == null)
                                ? (' ')
                                : ('Tickle shared by ' + userName),
                            sharePositionOrigin:
                                box!.localToGlobal(Offset.zero) & box.size);
                      }
                    },
                    child: Text('Share'),
                  ),
                  (user == null)
                      ? Container()
                      : ElevatedButton(
                          onPressed: () async {
                            //Uploading meme To Firebase Storage
                            ref = firebase_storage.FirebaseStorage.instance
                                .ref()
                                .child(
                                    'Posted-Memes/${Path.basename(_image!.path)}');
                            await ref.putFile(_image!).whenComplete(() async {
                              await ref.getDownloadURL().then((value) async {
                                likedMemeDoc = value.replaceAll(
                                    new RegExp(r'[^\w\s]+'), '0');
                                likedMemeDocFinal =
                                    likedMemeDoc.replaceAll('_', '0');
                                //sending the received url of uploaded meme to firestore along with userName, userID
                                await postedMemesRef
                                    .doc(likedMemeDocFinal)
                                    .set({
                                  'url': value,
                                  'Username': userName,
                                  'UserID': userId,
                                  'DateTime': DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString()
                                });
                                //Also storinging in a Memes Collection to use in top list
                                await memesCollectionRef
                                    .doc(likedMemeDocFinal)
                                    .set({
                                  'url': value,
                                  'Username': userName,
                                  'UserID': userId,
                                  'likedBy': [],
                                  'DateTime': DateTime.now()
                                      .microsecondsSinceEpoch
                                      .toString()
                                });
                              });
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Tickle posted'),
                              ),
                            );
                          },
                          child: Text('Post Tickle'),
                        )
                ],
              ),
      ),
    );
  }

  Widget? condition(
      {required bool condition, Widget? isTrue, Widget? isFalse}) {
    return condition ? isTrue : isFalse;
  }
}
