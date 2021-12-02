//import 'dart:html';

// ignore_for_file: unused_local_variable
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meme_g/widgets/user.dart';



class Auth {
  dynamic _useremail, _userpassword;
  final FirebaseAuth _Authenctication = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  UserF? _userfirebase(User user) {
    return user != null ? UserF.uid(user.uid) : null;
  }

  /*String getFirebaseUserId(User user){
    return user.uid;
  }*/

  //sign in Anonymously
  Future AnonymousSignIn() async {
    try {
      UserCredential response = await _Authenctication.signInAnonymously();
      User? user = response.user;
      return user;
    } catch (error) {
      return print(error.toString());
      return null;
    }
  }

  //sign in with email and password
  Future EmailandpassSignIn(_useremail, _userpassword) async {
    try {
      UserCredential response =
          await _Authenctication.signInWithEmailAndPassword(
              email: _useremail, password: _userpassword);
      User? user = response.user;
      return user;
    } catch (error) {
      return print(error.toString());
      return null;
    }
  }

  //create Account OR register account
  Future createAccount(_useremail, _userpassword) async {
    try {
      UserCredential response =
          await _Authenctication.createUserWithEmailAndPassword(
              email: _useremail, password: _userpassword);
      User? user = response.user;
      return user;
    } catch (error) {
      return print(error.toString());
      return null;
    }
  }

  //Google Sign-in
  Future googleSignin() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication google_auth = await googleUser!.authentication;
      AuthCredential user = GoogleAuthProvider.credential(
          accessToken: google_auth.accessToken, idToken: google_auth.idToken);
      return user;
    } catch (error) {
      print(error);
      print("signin failed");
    }
  }

  //sign out

}
 
