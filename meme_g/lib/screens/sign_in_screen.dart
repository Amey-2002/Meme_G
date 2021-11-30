import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/working/dummy_sign_in.dart';
import 'account_details_screen.dart';
import '../services/auth.dart';

class signIn extends  StatefulWidget
{
  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  final Auth _Authentication = Auth();
  @override
  Widget build(BuildContext context)
  {
    return  Scaffold(
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
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                //foregroundColor: Colors.green,
                //backgroundColor: Colors.white,
                onPressed: () async {
                  dynamic result =  await _Authentication.AnonymousSignIn();
                  if(result == null)
                  { print("sign in failed");}
                  else {
                    Navigator.pushNamed(context, Homescreen.route);
                    print(result.uid);
                  }
                },
                child: const Text(
                  'Sign In',
                ),
              ),
            ),
            Container(
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                //foregroundColor: Colors.green,
                //backgroundColor: Colors.white,
                onPressed: () { Navigator.pushNamed(context, Homescreen.route);},
                child: const Text(
                  'Guest',
                ),
              ),
            ),
            Container(
              child: FlatButton(
                textColor: Colors.white,
                color: Colors.green,
                //foregroundColor: Colors.green,
                //backgroundColor: Colors.white,
                onPressed: () { Navigator.pushNamed(context, DummySignIn.route);},
                child: const Text(
                  'Dummy',
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

                  onPressed: (){Navigator.pushNamed(context, Account_det.route);
                  print('accounts_det screen called');},
                  child: const Text('Create Account'),
                ),
              )
            ])
          ]
          ),
    )); 
  }
}


  
  