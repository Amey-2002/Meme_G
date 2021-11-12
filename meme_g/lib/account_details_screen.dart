import 'package:flutter/material.dart';
import 'textfields.dart';

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
            leading: Icon(
              Icons.format_list_numbered,
              color: Colors.green,
            ),
            title: Text('Birth Date'),
          ),
          Text_fields(),
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
