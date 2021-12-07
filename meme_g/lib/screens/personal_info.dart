import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:meme_g/screens/account_details_screen.dart';
import 'package:meme_g/screens/profile_image_picker.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/widgets/user.dart';
import '../widgets/textfields.dart';
//import 'account_details_screen.dart';
import 'homescreen.dart';

class personal_info extends StatefulWidget {
  static const route = 'personal_info_screen';

  //personal_info(this.uId);
  //String? uId;
  /*set setuid
  (UserId){
    uid = UserId;
  }*/
  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  // var account_info = Account_det();
  User? user = FirebaseAuth.instance.currentUser;
  late CollectionReference usersCollectionRef;
  bool isLoading = false;

  bool no_edit_info = true;


  //void edit_info() {}


  dynamic name, birthdate, country, username, emailid, upassword;

  var dp = new ProfilePage();
  void initState() {
    super.initState();
    isLoading = true;
    if (user != null) {
      dp.setUid = user!.uid; //uid acquired for user profile image
      print(user!.uid);
      usersCollectionRef = FirebaseFirestore.instance.collection('Users');
      usersCollectionRef
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          setState(() {
              name = documentSnapshot.get(FieldPath(['Name']));
              birthdate = documentSnapshot.get(FieldPath(['Birthdate']));
              country = documentSnapshot.get(FieldPath(['Country']));
              username = documentSnapshot.get(FieldPath(['Username']));
              emailid = documentSnapshot.get(FieldPath(['EmailId']));
              upassword = documentSnapshot.get(FieldPath(['Password']));
            
          });
          setState(() {
              isLoading = false;
            });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
        shadowColor: Colors.green,
      ),
      body: (user == null)
          ? const Center(
              heightFactor: double.infinity,
              widthFactor: double.infinity,
              child: Text('You are not Signed In'),
            )
          : Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      dp,
                      ListTile(
                        leading: Icon(
                          Icons.sort_by_alpha,
                          color: Colors.green,
                        ),
                        title: Text('Name'),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                no_edit_info = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                      ),
                      TextField(
                        controller: TextEditingController(text: name),
                        enableIMEPersonalizedLearning: true,
                        readOnly: no_edit_info,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.sort_by_alpha,
                          color: Colors.green,
                        ),
                        title: Text('User Id'),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                no_edit_info = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                      ),
                      TextField(
                        controller: TextEditingController(text: username),
                        enableIMEPersonalizedLearning: true,
                        readOnly: no_edit_info,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        title: Text('Email ID'),
                      ),
                      TextField(
                        controller: TextEditingController(text: emailid),
                        enableIMEPersonalizedLearning: true,
                        readOnly: no_edit_info,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.password,
                          color: Colors.green,
                        ),
                        title: Text('Password'),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                no_edit_info = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                      ),
                      TextField(
                        controller: TextEditingController(text: upassword),
                        obscureText: true,
                        obscuringCharacter: '*',
                        enableIMEPersonalizedLearning: true,
                        readOnly: no_edit_info,
                      ),
                      ListTile(
                        //tileColor: Colors.green.shade100,
                        leading: Icon(
                          //Icons.format_list_numbered,
                          Icons.calendar_today,
                          // color: Colors.green,
                        ),
                        title: Text("Birth Date"),
                        //Text('Birth Date'),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                no_edit_info = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                            )),
                      ),
                      TextField(
                        controller: TextEditingController(text: birthdate),
                        enableIMEPersonalizedLearning: true,
                        readOnly: no_edit_info,
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.perm_identity_sharp,
                          color: Colors.green,
                        ),
                        title: Text('Country of origin'),
                        trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                no_edit_info = false;
                              });
                            },
                            icon: Icon(
                              Icons.edit_location_alt_outlined,
                            )),
                      ),
                      TextField(
                        controller: TextEditingController(text: country),
                        enableIMEPersonalizedLearning: true,
                        readOnly: no_edit_info,
                      ),
                    ],
                  ),
                ),
                (isLoading)
                    ? Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.greenAccent),
                    )
                    : Container()
              ],
            ),
    );
  }
}
