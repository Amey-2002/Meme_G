import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';

class StaggeredPage extends StatefulWidget {
  static const route = 'collage_screen';

  const StaggeredPage({
    Key? key,
  }) : super(key: key);

  static const tiles = [
    // GridTile(2, 2),
    // GridTile(2, 1),
    // GridTile(1, 2),
    // GridTile(1, 1),
    // GridTile(2, 2),
    // GridTile(1, 2),
    // GridTile(1, 1),
    // GridTile(3, 1),
    GridTile(4, 3),
    GridTile(4, 3),
  ];

  @override
  State<StaggeredPage> createState() => _StaggeredPageState();
}

class _StaggeredPageState extends State<StaggeredPage> {
  File? _pickedImage = null;
  late firebase_storage.Reference ref;
  String imageUrl = '';
  bool uploading = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   ref = firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('Grid-Image/${Path.basename(_pickedImage!.path)}');
  // }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Staggered',
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 85,
            ),
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                ...StaggeredPage.tiles.mapIndexed((index, tile) {
                  //bool imageSet; // = false;
                  return StaggeredGridTile.count(
                      crossAxisCellCount: tile.crossAxisCount,
                      mainAxisCellCount: tile.mainAxisCount,
                      child: Stack(
                        children: [
                          (imageUrl != '')
                              ? ImageTile(
                                  imgUrl: imageUrl,
                                  index: index,
                                  width: tile.crossAxisCount * 100,
                                  height: tile.mainAxisCount * 100,
                                )
                              : IconButton(
                                  onPressed: () {
                                    _showPickOptionsDialog(context);
                                    // setState(() {
                                    //   imageSet = true;
                                    // });
                                  },
                                  icon: Icon(Icons.photo_album),
                                ),
                          uploading
                              ? Center(
                                  child: Text('Uploading...'),
                                )
                              : Container(),
                        ],
                      ));
                }),
              ],
            ),
          ],
        ),
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
      //_defaultImage = File(picked.path);
      //setState(() => controllerDefaultImage.text = _defaultImage!.path);
    }
    Navigator.pop(context);
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
        _pickedImage = cropped;
        // _defaultImage = cropped;
        // if (_defaultImage != null) {
        //   setState(() => controllerDefaultImage.text = _defaultImage!.path);
        // }
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

  Future _uploadProfileImg(BuildContext context) async {
    //Check Permissions
    // await Permission.photos.request();
    // var permissionStatus = await Permission.photos.status;
    // if (permissionStatus.isGranted) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Grid-Image/${Path.basename(_pickedImage!.path)}');
      await ref.putFile(_pickedImage!).whenComplete(() async {
        await ref.getDownloadURL().then((value) async {
          setState(() {
            imageUrl = value;
          });
          // await profileImgRef.doc(uid).set({'url': value});
          // profileImgRef
          //     .doc(uid)
          //     .get()
          //     .then((DocumentSnapshot documentSnapshot) {
          //   if (documentSnapshot.exists) {
          //     setState(() {
          //       profileImageUrl = documentSnapshot.get(FieldPath(['url']));
          //     });
          //   }
          // });
        });
      });
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (context) => AlertDialog(
    //       content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
    //         Text('Permission not granted. Try Again with permission access'),
    //         FlatButton(
    //           color: Colors.green,
    //           child: Text(
    //             'Ok',
    //             style: TextStyle(
    //               color: Colors.white,
    //             ),
    //           ),
    //           onPressed: () => Navigator.pop(context),
    //         ),
    //       ]),
    //     ),
    //   );
    // }
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
