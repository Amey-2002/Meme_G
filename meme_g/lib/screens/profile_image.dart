import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

dynamic uID = '';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);
  set setUid(uId) {
    uID = uId;
  }

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  late CollectionReference profileImgRef;
  String? profileImageUrl;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    profileImgRef = FirebaseFirestore.instance.collection('ProfileImageURL');
    if (uID != '') {
      profileImgRef.doc(uID).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
            profileImageUrl = documentSnapshot.get(FieldPath(['url']));
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      child: Container(
        decoration: const ShapeDecoration(
          shape: CircleBorder(),
          color: Colors.white,
        ),
        child: (profileImageUrl != null)
            ? ClipOval(child: Image.network(profileImageUrl!))
            : ClipOval(
                child:
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.account_circle_rounded),
                    //   // iconSize: 80,
                    // ),
                    Image.network(
                        'https://cdn3.iconfinder.com/data/icons/google-material-design-icons/48/ic_account_circle_48px-512.png'),
              ),
      ),
    );
  }
}
