import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meme_g/services/auth.dart';
import 'package:meme_g/widgets/user.dart';
import '../widgets/textfields.dart';
import 'homescreen.dart';

class Account_det extends StatefulWidget {
  static const route = 'account_det_screen';

  @override
  State<Account_det> createState() => _Account_detState();
}

dynamic name, userid, country;
String? birthdate; 
var emailid, upassword;

class _Account_detState extends State<Account_det> {
  var authObject = Auth();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Account Details'),
          shadowColor: Colors.green,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.sort_by_alpha,
              color: Colors.green,
            ),
            title: Text('Name'),
          ),
          Container(
            child: TextField(
                decoration: InputDecoration(hintText: "Enter name" ),
                onChanged: (uname) {
                  setState(() {
                    name = uname;
                  });
                }),
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
                onChanged: (uid) {
                  setState(() {
                    userid = uid;
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
            child: TextField(
                decoration: InputDecoration(hintText: "Enter EmailId "),
                onChanged: (email) {
                  setState(() {
                    emailid = email;
                  });
                }),
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
                    birthdate= date.toString();
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
            onChanged:(ucountry){
              setState(() {
                country = ucountry;
              });
            }
          ),
        ),
          ElevatedButton(
              child: Text("Create Account"),
              onPressed: () async {
                dynamic result =
                    await authObject.createAccount(emailid, upassword);
                if (result == null) {
                  print("Enter valid Details");
                } else {
                  UserF.accountDetails(name, userid, country, birthdate);
                 // Navigator.pop(context);
                 // Navigator.pushNamed(context, Homescreen.route);
                    Navigator.pushReplacementNamed(context, Homescreen.route);
                  print(result.uid);
                }
              })
        ])));
  }
}
