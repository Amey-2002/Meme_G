//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_g/widgets/user.dart';


class Auth {
  
  final FirebaseAuth _Authenctication =FirebaseAuth.instance;  
  UserF? _userfirebase(User user){
    return user !=null? UserF(uid :user.uid) :null;
  }
  
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