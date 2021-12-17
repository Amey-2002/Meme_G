import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meme_g/screens/profile_image.dart';
import 'package:share/share.dart';
import 'package:favorite_button/favorite_button.dart';

class MemeView extends StatefulWidget {
  final String imgUrl;
  final String userName;
  final String uid;
  late bool isLiked;
  late int likesCount;

  MemeView(
      {required this.imgUrl,
      required this.userName,
      required this.uid,
      required this.isLiked,
      required this.likesCount});

  @override
  State<MemeView> createState() => _MemeViewState();
}

class _MemeViewState extends State<MemeView> {
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference likedMemesRef;
  late String currentUsername;
  late String likedMemeDoc;
  late String likedMemeDocFinal;
  late CollectionReference memesCollectionRef;
  int likeCount = 0;

  var dp = new ProfileImage();

  @override
  void initState() {
    super.initState();
    likedMemeDoc = widget.imgUrl.replaceAll(new RegExp(r'[^\w\s]+'), '0');
    likedMemeDocFinal = likedMemeDoc.replaceAll('_', '0');
    memesCollectionRef = FirebaseFirestore.instance.collection('Memes');
    likedMemesRef = FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .collection('LikedMemeURLs');
    FirebaseFirestore.instance
        .collection('Users')
        .doc(user!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          currentUsername = documentSnapshot.get(FieldPath(['Username']));
        });
      }
    });
    dp.setUid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListTile(
              leading: dp,
              title: Text(
                widget.userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            height: 370,
            width: 370,
            child: Image(
              image: NetworkImage(widget.imgUrl),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                FavoriteButton(
                  isFavorite: widget.isLiked,
                  valueChanged: (_liked) {
                    widget.isLiked = !widget.isLiked;
                    if (widget.isLiked) {
                      memesCollectionRef.doc(likedMemeDocFinal).update({
                        'likedBy': FieldValue.arrayUnion([user!.uid])
                      });
                      likedMemesRef.doc(likedMemeDocFinal).set({
                        'url': widget.imgUrl,
                        'Username': widget.userName,
                        'DateTime':
                            DateTime.now().microsecondsSinceEpoch.toString()
                      });
                    } else {
                      memesCollectionRef.doc(likedMemeDocFinal).update({
                        'likedBy': FieldValue.arrayRemove([user!.uid])
                      });
                      likedMemesRef.doc(likedMemeDocFinal).delete();
                    }
                  },
                ),
                Text(
                  widget.likesCount.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  onPressed: () {
                    Share.share(widget.imgUrl +
                        ' Meme by ' +
                        widget.userName +
                        ' shared to you by ' +
                        currentUsername);
                  },
                  icon: Icon(
                    Icons.share,
                    size: 27,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
