import 'package:flutter/material.dart';
import 'package:meme_g/screens/emailandpass_signin.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'account_details_screen.dart';
import '../services/auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 300,
                width: double.infinity,
                child: Image.asset(
                  'assets/Wall post-amico (1).png',
                  
                ),
              ),
            

              Container(
                 padding: EdgeInsets.all(10),
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
                 padding: EdgeInsets.all(10),
                child: FloatingActionButton.extended(
                  heroTag: "btn2",
                  label: Text(
                    'Guest',
                  ),
                  onPressed: () async {
                    dynamic resultuser = await authObject.AnonymousSignIn();
                    if (resultuser == null) {
                      print("sign in failed");
                    } else {
                      Navigator.pushNamed(context, Homescreen.route);
                      print(resultuser.uid);
                    }
                  },
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Container(
                  child: Text('New User?'
                    //foregroundColor: Colors.green,
                    //backgroundColor: Colors.white,
                    ),
                  ),
                
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Account_det.route);
                      print('accounts_det screen called');
                    },
                    child: const Text('Create Account'),
                  ),
                )
              ]),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                shape:  RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                )  ,
                onPressed: () async {
                   dynamic resultuser = await authObject.googleSignin();
                  if (resultuser == null) {
                    print("sign in failed");
                  } else {
                   // Navigator.pop(context);
                   // Navigator.pushNamed(context, Homescreen.route);
                      Navigator.pushReplacementNamed(context, Homescreen.route);
                    print(resultuser.accessToken);
                  }
                  },
                   
              )
            ]),
      
    );
          
  }
}
