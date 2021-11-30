import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database{
  final String uid;
  Database({required this.uid});

  final CollectionReference memeCollection = FirebaseFirestore.instance.collection('memes');

  Future updateUserData({String? name, int? age,String? link}) async {
    return await memeCollection.doc(uid).set({
      'Name' : name,
      'Age' : age,
      'Link' : link
    });
  }
}