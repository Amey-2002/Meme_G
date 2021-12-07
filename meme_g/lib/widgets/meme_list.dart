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

  List<MemeView> latestMemes = [
    MemeView(
        userName: 'Username',
        imgUrl:
            'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memesCollectionRef = FirebaseFirestore.instance.collection('Memes');
    var latestMemesQuery = memesCollectionRef.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        latestMemes.add(MemeView(
          userName: documentSnapshot.get('Username'),
          imgUrl: documentSnapshot.get('url'),
        ));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //use height if you use ListView.builder
        height: 600, //435 for simulator & 580 for my mobile
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        //if ListView.builder is used then double double scrolling
        child: /*ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return latestMemes[index];
          },
        )*/

        StreamBuilder<QuerySnapshot>(
        stream: memesCollectionRef.orderBy('DateTime', descending: true)
            .snapshots(),
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
                        return MemeView(
                          imgUrl: snapshot.data?.docs[index].get('url'),
                          userName: snapshot.data?.docs[index].get('Username'),
                        );
                      }
                    },
                  ),
                );
        },
      ),
        /*child: Column(
        children: <Widget>[
          MemeView(
            img: Image.asset(
              'assets/dummyMemes/1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          MemeView(
            img: Image.asset(
              'assets/dummyMemes/2.png',
              fit: BoxFit.cover,
            ),
          ),
          MemeView(
            img: Image.asset(
              'assets/dummyMemes/3.png',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),*/
        );
  }
}
