import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_g/abstract%20class/guest_meme_view.dart';
import 'package:photo_view/photo_view.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/services/database.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class TemplatesScreen extends StatefulWidget {
  const TemplatesScreen({Key? key}) : super(key: key);
  static const route = 'my_work_screen';

  @override
  State<TemplatesScreen> createState() => _TemplatesScreenState();
}

  List<String> MemeName = [];
  List<String> MemeURL = [];

class _TemplatesScreenState extends State<TemplatesScreen> {
  late CollectionReference templatesRef;

  @override
  void initState() {
    super.initState();
    templatesRef = FirebaseFirestore.instance.collection('Templates');
    templatesRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        MemeName.add(result.get('name'));
        MemeURL.add(result.get('url'));
      }
    });
    _isSearching = false;
  }

  Widget appBarTitle = Text(
    "Search Example",
    style: TextStyle(color: Colors.white),
  );
  Icon icon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  late bool _isSearching;
  String _searchText = "";
  List searchresult = [];

  _TemplatesScreenState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _handleSearchStart();

    // templatesRef = FirebaseFirestore.instance.collection('Templates');
    // templatesRef.get().then((querySnapshot) {
    //   for (var result in querySnapshot.docs) {
    //     MemeName.add(result.get('name'));
    //     MemeURL.add(result.get('url'));
    //   }
    // });

    print(MemeURL);
    print(MemeName);

    return Scaffold(
      //key: globalKey,
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            setState(() {
              if (this.icon.icon == Icons.search) {
                this.icon = Icon(
                  Icons.close,
                  color: Colors.white,
                );
                this.appBarTitle = TextField(
                  controller: _controller,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)),
                  onChanged: searchOperation,
                );
                _handleSearchStart();
              } else {
                _handleSearchEnd();
              }
            });
          },
        ),
      ]),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: searchresult.length != 0 || _controller.text.isNotEmpty
                  ? GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: searchresult.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(3),
                          child: InkWell(
                            child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: searchresult[index],
                            ),
                            onTap: () async {
                              Navigator.pop(context, searchresult[index]);
                            },
                          ),
                        );
                      },
                    )
                  //: Container(),
                  : GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: MemeURL.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.all(3),
                          child: InkWell(
                            child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: MemeURL[index],
                            ),
                            onTap: () async {
                              Navigator.pop(context, MemeURL[index]);
                            },
                          ),
                        );
                      },
                    ),
            ),
            // Flexible(
            //   child: GridView.builder(
            //     scrollDirection: Axis.vertical,
            //     shrinkWrap: true,
            //     itemCount: MemeURL.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2),
            //     itemBuilder: (context, index) {
            //       return Container(
            //         margin: EdgeInsets.all(3),
            //         child: InkWell(
            //           child: FadeInImage.memoryNetwork(
            //             fit: BoxFit.cover,
            //             placeholder: kTransparentImage,
            //             image: MemeURL[index],
            //           ),
            //           onTap: () async {
            //             Navigator.pop(context, MemeURL[index]);
            //           },
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.icon = Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = Text(
        "Search Sample",
        style: TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null) {
      for (int i = 0; i < MemeName.length; i++) {
        String name = MemeName[i];
        String url = MemeURL[i];
        if (name.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(url);
        }
      }
    }
  }
}
