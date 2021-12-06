import 'package:flutter/material.dart';
import 'package:meme_g/screens/homescreen.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/widgets/textfields.dart';
import '../services/auth.dart';

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
    return Scaffold(
      appBar: AppBar(
        title : Text('Sign In'),
        backgroundColor: Colors.transparent,
        foregroundColor : Colors.black,
        elevation: 0,
      ),
       body: Card(
           elevation: 5, 
           shape: RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),  ),),
            
             child: Container(
               padding: EdgeInsets.all(30),
             child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
               Container(
                 padding: EdgeInsets.all(10),
                  height: 300,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/Mobile login-pana.png',  
                  ),
               ),
          
              TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Email Id ",
                    
                    ),
                  onChanged: (email) {
                    setState(() {
                      emailid = email;
                    });
                  }),
          
         
              TextField(
                decoration: InputDecoration(hintText: "Enter Password"),
                onChanged: (password) {
                  setState(() {
                    upassword = password.trim();
                  });
                },
                obscureText: true,
              ),
           SizedBox(
             height: 40.0,
           ),

          ElevatedButton(
                style : ButtonStyle(
                 padding : MaterialStateProperty.all(const EdgeInsets.all(10)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(5),
                      bottom: Radius.circular(15)),
                    )
                  )   ,
                  ),
                onPressed: () async {
                  dynamic resultuser =
                      await authObject.EmailandpassSignIn(emailid, upassword);
                  if (resultuser == null) {
                    print("sign in failed");
                  } else {
                    Navigator.pushNamed(context, Homescreen.route);
                    print(resultuser.uid);
                  }
                },
                
                child: Text("Let's Sign-in"))
        ],
      ),
      ),
           ),
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
