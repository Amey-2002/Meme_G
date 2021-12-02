import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:meme_g/screens/account_details_screen.dart';
import 'package:meme_g/services/auth.dart';
import '../widgets/textfields.dart';
import 'homescreen.dart';


class personal_info extends StatefulWidget {
  static const route = 'personal_info_screen';

  @override
  State<personal_info> createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
 // var account_info = Account_det();

  bool no_edit_info = true;

  void edit_info() {}

 // dynamic name, userid, country;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Personal Information'),
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
            controller: TextEditingController(text: userid),
            enableIMEPersonalizedLearning: true,
            readOnly: no_edit_info,
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.green,
            ),
            title: Text('Email ID'),
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
             controller: TextEditingController(text: birthdate ),
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
        ])));
  }
}
