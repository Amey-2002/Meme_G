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

class _TemplatesScreenState extends State<TemplatesScreen> {
  late CollectionReference templatesRef;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      templatesRef = FirebaseFirestore.instance
          .collection('Templates');
    } else {
      templatesRef = FirebaseFirestore.instance.collection('Users');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Templates')),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            templatesRef.snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: EdgeInsets.all(4),
                  child: GridView.builder(
                    itemCount: snapshot.data?.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(3),
                        child: InkWell(
                          child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: snapshot.data?.docs[index].get('url')),
                          onTap: () async {
                            Navigator.pop(context, snapshot.data?.docs[index].get('url'));
                            // showDialog(
                            //   context: context,
                            //   builder: (context) => AlertDialog(
                            //     content: Container(
                            //       child: GuestMemeView(
                            //         imgUrl:
                            //             snapshot.data?.docs[index].get('url'),
                            //         userName: snapshot.data?.docs[index]
                            //             .get('Username'),
                            //       ),
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  ),
                );
        },
      ),
    );
  }
}
