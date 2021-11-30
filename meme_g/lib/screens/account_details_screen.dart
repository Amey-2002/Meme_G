import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meme_g/screens/working/profile_image_picker.dart';
import '../widgets/textfields.dart';

class Account_det extends StatelessWidget {
  static const route = 'account_det_screen';

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
          /*Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: CircleAvatar(
                radius: 80,
                child: Icon(Icons.account_circle),
              ),
            ),
          ),*/
          ProfilePage(),
          /*RaisedButton(
            child: Text("Set Profile Picture"),
            onPressed: () {
            },
          ),*/
          //ProfilePage(),
          ListTile(
            leading: Icon(
              Icons.sort_by_alpha,
              color: Colors.green,
            ),
            title: Text('Name'),
          ),
          Text_fields(),
          ListTile(
            leading: Icon(
              Icons.sort_by_alpha,
              color: Colors.green,
            ),
            title: Text('Surname'),
          ),
          Text_fields(),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.green,
            ),
            title: Text('Email ID'),
          ),
          Text_fields(),
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
          Text_fields(),
        ])));
  }
}
