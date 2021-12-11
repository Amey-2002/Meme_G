import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/widgets/textfields.dart';
import '../services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class EmailandPass extends StatefulWidget {
  static const route = "Email_and_signin_page";
  @override
  _EmailandPassState createState() => _EmailandPassState();
}

class _EmailandPassState extends State<EmailandPass> {
  final snackBar = SnackBar(
    content: const Text('Yay! A SnackBar!'),
  );
  dynamic emailid, upassword;
  var authObject = new Auth();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
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
                // Navigator.pop(context);
                //Navigator.pushNamed(context, Homescreen.route);
                await Navigator.pushReplacementNamed(context, Homescreen.route);
                print(resultuser.uid);
                setState(() {
                  CircularProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                  );
                });
                //
              }
            },
            child: Text("Let's Sign-in"),
          ),
          SignInButton(
            Buttons.Google,
            text: "Sign In with Google",
            onPressed: () async {
              dynamic resultuser = await authObject.googleSignin();
              if (resultuser == null) {
                print("sign in failed");
              } else {
                setState(() {
                  google_details = true;
                });
                // Navigator.pop(context);
                // Navigator.pushNamed(context, Homescreen.route);
                // usersCollectionRef
                //     .doc(googleUserUid)
                //     .get()
                //     .then((DocumentSnapshot documentSnapshot) {
                //   if (documentSnapshot.exists) {
                //     setState(() {
                //       alreadyUser = true;
                //     });
                //   }
                // });
                Navigator.pushReplacementNamed(context, Homescreen.route);
                //print(resultuser.accessToken);
              }
            },
          )
        ],
      ),
    );
  }
}
