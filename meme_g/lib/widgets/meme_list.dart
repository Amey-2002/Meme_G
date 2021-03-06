import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/abstract%20class/guest_meme_view.dart';
import '../abstract class/meme_view.dart';

class MemeList extends StatefulWidget {
  @override
  State<MemeList> createState() => _MemeListState();
}

class _MemeListState extends State<MemeList> {
  User? user = FirebaseAuth.instance.currentUser;

  late CollectionReference memesCollectionRef;
  var latestMemesQuery;

  // List<MemeView> latestMemes = [
  //   MemeView(
  //       userName: 'Username',
  //       imgUrl:
  //           'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memesCollectionRef = FirebaseFirestore.instance.collection('Memes');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          memesCollectionRef.orderBy('DateTime', descending: true).snapshots(),
      builder: (context, snapshot) {
        return !snapshot.hasData
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: EdgeInsets.all(4),
                child: ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    if (user == null) {
                      return GuestMemeView(
                        imgUrl: snapshot.data?.docs[index].get('url'),
                        userName: snapshot.data?.docs[index].get('Username'),
                      );
                    } else {
                      List array = snapshot.data?.docs[index].get('likedBy');
                      bool _isLiked = array.contains(user!.uid);
                      return MemeView(
                        imgUrl: snapshot.data?.docs[index].get('url'),
                        userName: snapshot.data?.docs[index].get('Username'),
                        uid: snapshot.data?.docs[index].get('UserID'),
                        isLiked: _isLiked,
                        likesCount: array.length,
                      );
                    }
                  },
                ),
              );
      },
    );
  }
}
