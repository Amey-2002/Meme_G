import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/widgets/textfields.dart';
import '../services/auth.dart';

class EmailandPass extends StatefulWidget {
  static const route = "Email_and_signin_page";
  @override
  _EmailandPassState createState() => _EmailandPassState();
}

class _EmailandPassState extends State<EmailandPass> {
  dynamic emailid, upassword;
  var authObject = new Auth();
  @override
  Widget build(BuildContext context) {
    return Card(
        child : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: TextField(
              decoration: InputDecoration(hintText: "Enter EmailId "),
              onChanged: (email) {
                setState(() {
                  emailid = email;
                });
              }),
        ),
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
        ElevatedButton(
            onPressed: () async {
              dynamic resultuser =
                  await authObject.EmailandpassSignIn(emailid, upassword);
              if (resultuser == null) {
                print("sign in failed");
              } else {
                 Navigator.pop(context);
                Navigator.pushNamed(context, Homescreen.route);
               
                print(resultuser.uid);
              }
            },
            child: Text("Let's Sign-in"))
      ],
    )
    );
  }
}
