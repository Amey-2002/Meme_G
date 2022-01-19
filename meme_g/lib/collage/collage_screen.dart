import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_g/collage/collage_menu.dart';
import 'package:meme_g/screens/editor/flutter_ie_pro.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'common.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:path_provider/path_provider.dart';

class StaggeredPage extends StatefulWidget {
  static const route = 'collage_screen';


  late int noOfTiles;
  StaggeredPage.general();
  StaggeredPage.grid(this.noOfTiles);
  
  List tiles = [];



  @override
  State<StaggeredPage> createState() => _StaggeredPageState();
}


class _StaggeredPageState extends State<StaggeredPage> {

  var select =  new StaggeredPage.general();
  void selectTile(noOfTiles){
    switch (noOfTiles) {
    case 1: {
      var tiles1 = [
    GridTile(6, 6),
  ];
    select.tiles = tiles1;
    } break;
    case 2: {
      var tiles2 = [
    GridTile(6, 3),
    GridTile(6, 3),
  ];
  select.tiles = tiles2;
    } break;
    case 3: {
      var tiles3 = [
    GridTile(3, 6),
    GridTile(3, 3),
    GridTile(3, 3),
  ];
  select.tiles = tiles3;
    } break;
    case 5: {
      var tiles5 = [
    GridTile(3, 3),
    GridTile(3, 3),
    GridTile(6, 3),
  ];
  select.tiles = tiles5;
    } break;
    case 4: {
      var tiles4 = [
    GridTile(3, 3),
    GridTile(3, 3),
    GridTile(3, 3),
    GridTile(3, 3),
  ];
  select.tiles = tiles4;
    } break;
    case 6: {
      var tiles6 = [
        GridTile(3, 2),
        GridTile(3, 2),
        GridTile(3, 2),
        GridTile(3, 2),
        GridTile(3, 2),
        GridTile(3, 2),
      ];
    select.tiles = tiles6;
    }
    break;
    default: {
      
    } break;
    }
  }

  ScreenshotController screenshotController = ScreenshotController();

  File? _pickedImage = null;
  late firebase_storage.Reference ref;
  String imageUrl = '';
  bool uploading = false;

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
    _toastInfo(info);
  }

  @override
  void initState() {
    _requestPermission();
  }

  

  @override
  Widget build(BuildContext context) {
    selectTile(widget.noOfTiles);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, GridMenu.route);
          },
          icon: Icon(
            Icons.arrow_back,
          ),
        ),
        //title: Text('2'),
        actions: [
          IconButton(
            onPressed: () {
              screenshotController
                  .capture(
                delay: const Duration(milliseconds: 10),
                pixelRatio: 1.5,
              )
                  .then((binaryIntList) async {
                final paths = await getTemporaryDirectory();
                final _file = await File(
                        '${paths.path}/' + DateTime.now().toString() + '.jpg')
                    .create();
                _file.writeAsBytesSync(binaryIntList!);
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageEditorPro(
                        arguments: _file,
                      ),
                    ),
                  );
                });
                Navigator.pop(context, _file);
              }).catchError((onError) {
                print(onError);
              });
            },
            icon: Icon(Icons.done),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 85,
            ),
            Screenshot(
              controller: screenshotController,
              child: StaggeredGrid.count(
                crossAxisCount: 6,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
                children: [
                  ...select.tiles.mapIndexed((index, tile) {
                    return StaggeredGridTile.count(
                      crossAxisCellCount: tile.crossAxisCount,
                      mainAxisCellCount: tile.mainAxisCount,
                      child: ImageTile(
                        index: index,
                        width: tile.crossAxisCount * 100,
                        height: tile.mainAxisCount * 100,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridTile {
  const GridTile(this.crossAxisCount, this.mainAxisCount);
  final int crossAxisCount;
  final int mainAxisCount;
}
