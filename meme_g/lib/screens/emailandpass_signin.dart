import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/widgets/textfields.dart';
import '../services/auth.dart';

class EmailandPass extends StatefulWidget {
  
  static const route = "Email_and_signin_page";
  dynamic email, password;
  @override
  _EmailandPassState createState() => _EmailandPassState();
}

class _EmailandPassState extends State<EmailandPass> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(hintText: "Enter EmailId "),
          onChanged:(email){
            setState(() {
              email = email;
            });
          }
        ),
        TextField(
          decoration: InputDecoration(hintText: "Enter Password"),
          onChanged: (password){
            password = password.trim();
          },
          obscureText: true,
        ),
        ElevatedButton(
            onPressed: () async {
              dynamic result = await Auth.EmailandpassSignIn();
              if (result == null) {
                print("sign in failed");
              } else {
                Navigator.pushNamed(context, EmailandPass.route);
                print(result.uid);
              }
            },
            child: Text("Login In"))
      ],
    ));
  }
}
