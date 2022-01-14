import 'package:flutter/material.dart';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';

import 'templates_screen.dart';

const _defaultColor = Color(0xFF34568B);

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    Key? key,
    required this.title,
    this.topPadding = 0,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: child,
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({
    Key? key,
    required this.index,
    this.extent,
    this.backgroundColor,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      color: backgroundColor ?? _defaultColor,
      height: extent,
      child: Center(
        child: CircleAvatar(
          minRadius: 20,
          maxRadius: 20,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: Text('$index', style: const TextStyle(fontSize: 20)),
        ),
      ),
    );

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        )
      ],
    );
  }
}

class ImageTile extends StatefulWidget {
  const ImageTile({
    Key? key,
    required this.index,
    required this.width,
    required this.height,
  }) : super(key: key);

  final int index;
  final int width;
  final int height;

  @override
  State<ImageTile> createState() => _ImageTileState();
}

class _ImageTileState extends State<ImageTile> {
  File? _pickedImage = null;
  late firebase_storage.Reference ref;
  String imageUrl = '';
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    // return Image.network(
    //   imgUrl,
    //   //'https://picsum.photos/$width/$height?random=$index',
    //   width: width.toDouble(),
    //   height: height.toDouble(),
    //   fit: BoxFit.cover,
    // );
    return Stack(
      children: [
        (imageUrl != '')
            ? Image.network(
                imageUrl,
                //'https://picsum.photos/$width/$height?random=$index',
                width: widget.width.toDouble(),
                height: widget.height.toDouble(),
                fit: BoxFit.fill,
              )
            // ? ImageTile(
            //     imgUrl: imageUrl,
            //     index: widget.index,
            //     width: tile.crossAxisCount * 100,
            //     height: tile.mainAxisCount * 100,
            //   )
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
                child: Text('Getting the Image...'),
              )
            : Container(),
      ],
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
            ),
            ListTile(
              leading: Icon(Icons.photo_album),
              title: Text("Use a Template"),
              onTap: () {
                _showTemplates(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  _showTemplates(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TemplatesScreen(),
      ),
    );

    setState(() {
      imageUrl = result;
    });

    Navigator.pop(context);

    // showDialog(
    //   context: context,
    //   builder: (context) => AlertDialog(
    //     content: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         InkWell(
    //           child: Image.network(
    //             'https://indianmemetemplates.com/wp-content/uploads/abhi-maza-ayega-na-bhidu.jpg',
    //             fit: BoxFit.cover,
    //           ),
    //           onTap: () {
    //             setState(() {
    //               imageUrl =
    //                   'https://indianmemetemplates.com/wp-content/uploads/abhi-maza-ayega-na-bhidu.jpg';
    //             });
    //             Navigator.pop(context);
    //             Navigator.pop(context);
    //           },
    //         ),
    //         InkWell(
    //           child: Image.network(
    //             'https://i.ytimg.com/vi/KMDPqUEPoZI/hqdefault.jpg',
    //             fit: BoxFit.cover,
    //           ),
    //           onTap: () {
    //             setState(() {
    //               imageUrl = 'https://i.ytimg.com/vi/KMDPqUEPoZI/hqdefault.jpg';
    //             });
    //             Navigator.pop(context);
    //             Navigator.pop(context);
    //           },
    //         ),
    //       ],
    //     ),
    //   ),
    // );
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
  }
}

class InteractiveTile extends StatefulWidget {
  const InteractiveTile({
    Key? key,
    required this.index,
    this.extent,
    this.bottomSpace,
  }) : super(key: key);

  final int index;
  final double? extent;
  final double? bottomSpace;

  @override
  _InteractiveTileState createState() => _InteractiveTileState();
}

class _InteractiveTileState extends State<InteractiveTile> {
  Color color = _defaultColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (color == _defaultColor) {
            color = Colors.red;
          } else {
            color = _defaultColor;
          }
        });
      },
      child: Tile(
        index: widget.index,
        extent: widget.extent,
        backgroundColor: color,
        bottomSpace: widget.bottomSpace,
      ),
    );
  }
}
