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

class MyWork extends StatefulWidget {
  const MyWork({Key? key}) : super(key: key);
  static const route = 'my_work_screen';

  @override
  State<MyWork> createState() => _MyWorkState();
}

class _MyWorkState extends State<MyWork> {
  //User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference postedMemesRef;

  User? user = FirebaseAuth.instance.currentUser; 

  /*checkAuthentification() async {
    _auth.authStateChanges().listen((user) {
      _user = user;
    });
  }*/

  /*getUser() async {
    User? firebaseUser = _auth.currentUser;

    await firebaseUser?.reload();

    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this._user = firebaseUser;

        this.isloggedin = true;
      });
    }
  }*/

  @override
  void initState() {
    super.initState();
    if (user != null) {
      postedMemesRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user!.uid)
          .collection('PostedMemeURLs');
    } else {
      postedMemesRef = FirebaseFirestore.instance.collection('Users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Posted Memes')),
      body: (user == null)
          ? const Center(
              heightFactor: double.infinity,
              widthFactor: double.infinity,
              child: Text('You are not Signed In'),
            )
          : StreamBuilder<QuerySnapshot>(
              stream: postedMemesRef
                  .orderBy('DateTime', descending: true)
                  .snapshots(),
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
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(3),
                                child: InkWell(
                                    child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: kTransparentImage,
                                        image: snapshot.data?.docs[index]
                                            .get('url')),
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Container(
                                            child: GuestMemeView(
                                              imgUrl: snapshot.data?.docs[index]
                                                  .get('url'),
                                              userName: snapshot
                                                  .data?.docs[index]
                                                  .get('Username'),
                                            ),
                                            /*Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.arrow_back),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),*/
                                            //     PhotoView(
                                            //   imageProvider: NetworkImage(
                                            //     snapshot.data?.docs[index]
                                            //         .get('url'),
                                            //   ),
                                            // ),
                                            /*],
                                      ),*/
                                          ),
                                        ),
                                      );
                                    }),
                              );
                            }),
                      );
              },
            ),
    );
  }
}
