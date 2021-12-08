import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/services/auth.dart';

import 'package:meme_g/widgets/user.dart';
import '../widgets/textfields.dart';
import 'homescreen.dart';
import 'package:meme_g/screens/profile_image_picker.dart';

class Account_det extends StatefulWidget {
  static const route = 'account_det_screen';

  @override
  State<Account_det> createState() => _Account_detState();
}

dynamic name, username, country;
String? birthdate;
var emailid, upassword;

class _Account_detState extends State<Account_det> {
  var authObject = Auth();
  //  dynamic name, username, country;
  // var emailid, upassword;
  late GoogleSignInAccount google_user;
  @override
  bool no_edit_info = true;
  var dp = new ProfilePage();

  late CollectionReference usersCollectionRef;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if(google_details){
      name = google_user.displayName;
      emailid = google_user.email;}
    });
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Details'),
          shadowColor: Colors.green,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          /*Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 80,
                child: Icon(Icons.account_circle),
              ),
            ),
          ),*/
          //ProfilePage().setUid = userid,

          /*RaisedButton(
            child: Text("Set Profile Picture"),
            onPressed: () {
            },
          ),*/
          //ProfilePage(),
          //dp,
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
          Container(
            child: (google_details)
                ? TextField(
                    decoration: InputDecoration(hintText: "Enter name"),
                    onChanged: (uname) {
                      setState(() {
                        name = uname;
                      });
                    })
                : Container(
                    child: TextField(
                      controller: TextEditingController(text: name),
                      enableIMEPersonalizedLearning: true,
                      readOnly: no_edit_info,
                    ),
                  ),
          ),
          ListTile(
            leading: Icon(
              Icons.sort_by_alpha,
              color: Colors.green,
            ),
            title: Text('User Id'),
          ),

          Container(
            child: TextField(
                decoration: InputDecoration(hintText: "Enter UserId "),
                onChanged: (userName) {
                  setState(() {
                    username = userName;
                  });
                }),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.green,
            ),
            title: Text('Email ID'),
          ),
          // Text_fields("Enter EmailId",emailid),
          Container(
            child: (google_details)
                ? TextField(
                    decoration: InputDecoration(hintText: "Enter EmailId "),
                    onChanged: (email) {
                      setState(() {
                        emailid = email;
                      });
                    })
                : Container(
                    child: TextField(
                      controller: TextEditingController(text: emailid),
                      enableIMEPersonalizedLearning: true,
                      readOnly: no_edit_info,
                    ),
                  ),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.green,
            ),
            title: Text('Password'),
          ),
          // Text_fields("Enter password",upassword),
          Container(
            child: TextField(
              decoration: InputDecoration(hintText: "Enter Password"),
              onChanged: (password) {
                setState(() {
                  upassword = password.trim();
                });
              },
              obscureText: true,
            ),
          ),
          ListTile(
            tileColor: Colors.green.shade100,
            leading: Container(
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(16.0),
                color: Colors.white,
              ),
              child: Icon(
                //Icons.format_list_numbered,
                Icons.calendar_today,
                color: Colors.green,
              ),
            ),
            title: TextButton(
              onPressed: () {
                DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1971, 1, 1),
                    maxTime: DateTime(2021, 1, 1),
                    theme: DatePickerTheme(
                        headerColor: Colors.green,
                        backgroundColor: Colors.white,
                        itemStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 18),
                        doneStyle:
                            TextStyle(color: Colors.white, fontSize: 16)),
                    onChanged: (date) {
                  print('change $date in time zone ' +
                      date.timeZoneOffset.inHours.toString());
                }, onConfirm: (date) {
                  print('confirm $date');
                  setState(() {
                    birthdate = date.toString();
                  });
                }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.circular(16.0),
                  color: Colors.green.shade100,
                ),
                child: Text(
                  'Choose Birthdate',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 17),
                  //style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
            //Text('Birth Date'),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_identity_sharp,
              color: Colors.green,
            ),
            title: Text('Country of origin'),
          ),

          Container(
            child: TextField(
                decoration: InputDecoration(hintText: "Enter country  "),
                onChanged: (ucountry) {
                  setState(() {
                    country = ucountry;
                  });
                }),
          ),

          ElevatedButton(
              child: Text("Create Account"),
              onPressed: () async {
                dynamic result =
                    await authObject.createAccount(emailid, upassword);
                if (result == null) {
                  print("Enter valid Details");
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Account could not be created! Please Enter valid Emailid or password'),
                    ),
                  );
                } else {
                  //using dialogue box to set profile Image
                  setState(() {
                    dp.setUid =
                        result.uid; //uid acquired for user profile image
                  });
                  UserF.accountDetails(name, username, country, birthdate);
                  _updateToDatabase(
                      uid: result.uid,
                      uName: name,
                      uBirthdate: birthdate,
                      uCountry: country,
                      uEmailId: emailid,
                      uPassword: upassword,
                      userName: username);
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          dp,
                          ClipRRect(
                            child: RaisedButton(
                              color: Colors.green,
                              child: Text('Done'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          ClipRRect(
                            child: RaisedButton(
                              color: Colors.grey,
                              child: Text('Later'),
                              onPressed: () => Navigator.pop(context),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  // Navigator.pop(context);
                  // Navigator.pushNamed(context, Homescreen.route);
                  Navigator.pushReplacementNamed(context, Homescreen.route);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created successfully'),
                    ),
                  );
                  print(result.uid);
                }
              })
        ])));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usersCollectionRef = FirebaseFirestore.instance.collection('Users');
  }

  void _updateToDatabase(
      {required String uid,
      dynamic uName,
      dynamic userName,
      dynamic uCountry,
      dynamic uBirthdate,
      dynamic uEmailId,
      dynamic uPassword}) {
    usersCollectionRef.doc(uid).set({
      'Name': uName,
      'Username': userName,
      'EmailId': uEmailId,
      'Password': uPassword,
      'Country': uCountry,
      'Birthdate': uBirthdate,
    });
  }
}
