//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meme_g/widgets/user.dart';

 class Auth {
  dynamic _useremail, _userpassword;
  final FirebaseAuth _Authenctication =FirebaseAuth.instance;  
  UserF? _userfirebase(User user){
    return user !=null? UserF.uid(user.uid) :null;
  }
  
  //sign in Anonymously
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
   Future EmailandpassSignIn(_useremail,_userpassword) async {
     try{
   UserCredential response =   await _Authenctication.signInWithEmailAndPassword(email:_useremail, password:_userpassword);
   User?  user = response.user;
   return user;
     }catch(error){
      return print(error.toString());
      return null;
     }
   }

  //create Account OR register account 
   Future createAccount(_useremail,_userpassword) async { 
   try{
   UserCredential response = await  _Authenctication.createUserWithEmailAndPassword(email:_useremail, password:_userpassword);
    User?  user = response.user;
   return user;
   }
   catch(error){
      return print(error.toString());
      return null;
   }
   }
  //sign out

 
}