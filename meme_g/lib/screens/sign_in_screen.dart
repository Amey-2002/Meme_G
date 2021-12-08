import 'package:flutter/material.dart';
import 'package:meme_g/screens/emailandpass_signin.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'account_details_screen.dart';
import '../services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

bool google_details = false;

class signIn extends StatefulWidget {
  @override
    static const route = "Sign in screen";
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  final Auth _Authentication = Auth();
  dynamic emailid, upassword;

  var authObject = new Auth();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
        body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                icon: Icon(Icons.login_sharp),
                onPressed: () {
                  Navigator.pushNamed(context, EmailandPass.route);
                },
                label: Text(
                  'Sign In',
                ),
              ),
            ),
            Container(
              child: FloatingActionButton.extended(
                heroTag: "btn2",
                label: Text(
                  'Guest',
                ),
                onPressed: () async {
                  Navigator.pushNamed(context, Homescreen.route);
                  /*dynamic resultuser = await authObject.AnonymousSignIn();
                  if (resultuser == null) {
                    print("sign in failed");
                  } else {
                    Navigator.pushNamed(context, Homescreen.route);
                    print(resultuser.uid);
                  }*/
                },
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                child: TextButton(
                  //foregroundColor: Colors.green,
                  //backgroundColor: Colors.white,
                  onPressed: () {},
                  child: const Text(
                    'New user ?',
                  ),
                ),
              ),
              Container(
                child: TextButton(
                  onPressed: () {
                   // Navigator.pushNamed(context, Account_det.route);
                       Navigator.pushReplacementNamed(context, Account_det.route);
                    print('accounts_det screen called');
                  },
                  child: const Text('Create Account'),
                ),
              )
            ]),
            SignInButton(
              Buttons.Google,
              text: "Sign up with Google",
              onPressed: () async {
                  dynamic resultuser = await authObject.googleSignin();
                  if (resultuser == null) {
                    print("sign in failed");
                  } else {
                    setState(() {
                      google_details=true;
                    });
                   // Navigator.pop(context);
                   // Navigator.pushNamed(context, Homescreen.route);
                      Navigator.pushReplacementNamed(context, Account_det.route);
                    //print(resultuser.accessToken);
                  }
                },
            )
          ]),
    ));
  }
}
