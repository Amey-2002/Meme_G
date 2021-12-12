import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:favorite_button/favorite_button.dart';

class MemeView extends StatefulWidget {
  final String imgUrl;
  final String userName;
  late bool isLiked;

  MemeView(
      {required this.imgUrl, required this.userName, required this.isLiked});

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
  //bool liked = false;

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
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc(user!.uid)
    //     .collection('LikedMemeURLs')
    //     .doc(likedMemeDocFinal)
    //     .get()
    //     .then((DocumentSnapshot documentSnapshot) {
    //   if (documentSnapshot.exists) {
    //     setState(() {
    //       liked = true;
    //       print(documentSnapshot.get(FieldPath(['url'])));
    //     });
    //   }
    // });
    // print(liked);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 37,
                ),
                title: Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
              /*Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const <Widget>[
                Icon(
                  Icons.account_circle,
                  size: 37,
                ),
                (widget.userName == null)?
                Text(
                   'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ) :
                
                Text(
                  widget.userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),*/
              ),
          Container(
            height: 330,
            width: 330,
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
                //Icon(Icons.favorite_border,size: 27,),
                //Icon(Icons.send,size: 27,),
                //Icon(Icons.share,size: 27,),
                FavoriteButton(
                  isFavorite: widget.isLiked,
                  // iconDisabledColor: Colors.white,
                  valueChanged: (_liked) {
                    widget.isLiked = !widget.isLiked;
                    //List array = likedMemesRef.doc(likedMemeDocFinal).get(Field) as List;
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
                    // if (_liked) {
                    //   likedMemesRef.doc(likedMemeDocFinal).set({
                    //     'url': widget.imgUrl,
                    //     'Username': widget.userName,
                    //     'DateTime':
                    //         DateTime.now().microsecondsSinceEpoch.toString()
                    //   });
                    // } else {
                    //   likedMemesRef.doc(likedMemeDocFinal).delete();
                    // }
                  },
                ),
                /*RaisedButton(
                  //Shubham : I tried using using this which is a property of ElevatedButton
                  /*style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return Colors.greenAccent;
                      return Colors.grey;
                    }),
                  ),*/
                  color: liked ? Colors.greenAccent[700] : Colors.grey,
                  onPressed: () async {
                    liked = !liked;
                    if (liked) {
                      likedMemesRef.doc(likedMemeDocFinal).set({
                        'url': widget.imgUrl,
                        'Username': widget.userName,
                        'DateTime':
                            DateTime.now().microsecondsSinceEpoch.toString()
                      });
                    } else {
                      likedMemesRef.doc(likedMemeDocFinal).delete();
                    }
                    //print(likedMemeDocFinal);
                    //setState(() => pressAttention = false);
                    /*await likedMemesRef.doc(likedMemeDocFinal).set({
                      'url': widget.imgUrl,
                      'Username': widget.userName,
                      'DateTime':
                          DateTime.now().microsecondsSinceEpoch.toString()
                    });*/
                  },
                  child: Icon(
                    Icons.favorite_border,
                    size: 27,
                  ),
                ),*/
                //IconButton(onPressed: () {}, icon: Icon(Icons.send,size: 27,)),
                RaisedButton(
                  color: Colors.greenAccent[700],
                  onPressed: () {
                    Share.share(widget.imgUrl +
                        ' Meme by ' +
                        widget.userName +
                        ' shared to you by ' +
                        currentUsername);
                  },
                  child: Icon(
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
