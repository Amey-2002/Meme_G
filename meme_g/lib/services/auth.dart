//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  
  final FirebaseAuth _Authenctication =FirebaseAuth.instance;  
  
  //sign in Anonymously //FirebaseUser issue pending
   Future AnonymousSignIn() async {
     try{
   UserCredential response =   await _Authenctication.signInAnonymously();
   User?  user = response.user;
   return user;
     }catch(error){
      return print(error.toString());
      return null;
     }
   }
  //sign in with email and password

  //create Account OR register

  //sign out

 
}