import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  
  final FirebaseAuth _Authenctication =FirebaseAuth.instance;  
  
  //sign in Anonymously //FirebaseUser issue pending
   Future AnonymousSign() async {
     try{
   UserCredential response =   await _Authenctication.signInAnonymously();
  
     }catch(error){
      return print(error.toString());
     }
   }
  //sign in with email and password

  //create Account OR register

  //sign out

 
}