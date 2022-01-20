// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meme_g/screens/account_details_screen.dart';
import 'package:meme_g/screens/sign_in_screen.dart';
import 'package:meme_g/widgets/user.dart';

User? uSer;

class Auth extends StatefulWidget {
  dynamic _useremail, _userpassword;
  final FirebaseAuth _Authenctication = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  UserF? _userfirebase(User user) {
    return user != null ? UserF.uid(user.uid) : null;
  }

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
      UserCredential google_user =
          await _Authenctication.signInWithCredential(user);
      uSer = FirebaseAuth.instance.currentUser;
      googleUserUid = uSer!.uid;
      print(uSer!.displayName);

      return googleUser;
    } catch (error) {
      print(error);
      print("signin failed");
    }
  }

  //sign out
  Future<User?> signout() async {
    try {
      await _Authenctication.signOut();
      print("signed out");
    } catch (error) {
      print(error);
    }
  }

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  @override
  Widget build(BuildContext context) {
    setState(() {
      name = uSer!.displayName;
      emailid = uSer!.email;
    });
    return Container();
  }
}
