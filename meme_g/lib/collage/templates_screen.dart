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

//[]; //
//List<String> MemeName = []; //[
//   'crying cat with thumbs up',
//   'what confused guy',
//   'panic choice',
//   'carry minati bahut tez ho rahe ho',
//   'abhi maza ayega na bhidu',
//   'drake yes no',
//   'samaj mai aaya kya',
//   'happy sad terrified',
//   'oh bhai maaro mujhe maaro',
//   'happy and sad breaking bad hank',
// ];
//List<String> MemeURL = []; //[
//   'https://i.ytimg.com/vi/KMDPqUEPoZI/hqdefault.jpg',
//   'https://newfastuff.com/wp-content/uploads/2019/02/In6n7FK-300x256.png',
//   'https://i.imgflip.com/4/1g8my4.jpg',
//   'https://humornama.com/wp-content/uploads/2020/12/Bahut-Tez-Ho-Rahe-Ho-meme-template-of-CarryMinati.jpg',
//   'https://indianmemetemplates.com/wp-content/uploads/abhi-maza-ayega-na-bhidu.jpg',
//   'https://firebasestorage.googleapis.com/v0/b/meme-generator-692dc.appspot.com/o/Grid-Image%2Fdrake_meme.png?alt=media&token=46f7436f-8768-4fdd-9503-535a0f66c521',
//   'https://firebasestorage.googleapis.com/v0/b/meme-generator-692dc.appspot.com/o/uploads%2Fsamaj%20mai%20aaya%20kya%20meme.jpg?alt=media&token=fd2b36e0-53de-4db0-9886-19683d90f3e7',
//   'https://i0.wp.com/adthejokester.com/wp-content/uploads/2021/10/incredible-man-meme-template-people-who-know.jpg?resize=860%2C484&ssl=1',
//   'https://i.pinimg.com/originals/5d/c6/2f/5dc62f43e8f5bd6c8e04f901215e5eb0.png',
//   'https://i.kym-cdn.com/entries/icons/original/000/036/981/cover1.jpg',
// ];

class _TemplatesScreenState extends State<TemplatesScreen> {
  CollectionReference templatesRef =
      FirebaseFirestore.instance.collection('Templates');
  List<String> MemeURL = [];
  List<String> MemeName = [];

  void getTemplatesFromFirestore() async {
    await templatesRef.get().then((querySnapshot) {
      for (var result in querySnapshot.docs) {
        MemeName.add(result.get('name'));
        MemeURL.add(result.get('url'));
      }
    });
  }

  @override
  void initState() {
    super.initState();
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
  bool listEmpty = true;

  @override
  Widget build(BuildContext context) {
    if (MemeURL == []) {
      listEmpty = true;
    }

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: icon,
          onPressed: () {
            listEmpty = false;
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
      body: (listEmpty)
          ? StreamBuilder<QuerySnapshot>(
              stream: templatesRef.snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: EdgeInsets.all(4),
                        child: GridView.builder(
                          itemCount: snapshot.data?.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.all(3),
                              child: InkWell(
                                child: FadeInImage.memoryNetwork(
                                    fit: BoxFit.cover,
                                    placeholder: kTransparentImage,
                                    image:
                                        snapshot.data?.docs[index].get('url')),
                                onTap: () async {
                                  Navigator.pop(context,
                                      snapshot.data?.docs[index].get('url'));
                                },
                              ),
                            );
                          },
                        ),
                      );
              },
            )
          : Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: (searchresult.length != 0 ||
                            _controller.text.isNotEmpty)
                        ? GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: searchresult.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
                        : GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: MemeURL.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
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
